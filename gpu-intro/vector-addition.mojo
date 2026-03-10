from sys import has_accelerator, exit

from gpu.host import DeviceContext
from gpu import block_dim, block_idx, thread_idx

from math import ceildiv

from layout import Layout, LayoutTensor

# Vector data type and size
comptime float_dtype = DType.float32
comptime vector_size = 1024
comptime block_size = 256
comptime num_blocks = ceildiv(vector_size, block_size)
comptime layout = Layout.row_major(vector_size)


fn vector_addition(
        lhs_tensor: LayoutTensor[float_dtype, layout, MutAnyOrigin],
        rhs_tensor: LayoutTensor[float_dtype, layout, MutAnyOrigin],
        out_tensor: LayoutTensor[float_dtype, layout, MutAnyOrigin],
        ):
    """Calculate the element-wise sum of 2 vectors on the GPU."""
    
    # Calculate the index of the vector element for the thread to process
    var tid = block_idx.x * block_dim.x + thread_idx.x

    # Don't process out-of-bounds elements
    if tid < vector_size:
        out_tensor[tid] = lhs_tensor[tid] + rhs_tensor[tid]


def main():
    @parameter
    if not has_accelerator():
        print("No compatible GPU found")
        exit(1)

    # GPU device
    ctx = DeviceContext()
    print("Found GPU:", ctx.name())

    # Create host-visible staging buffers for initialization and reading back.
    lhs_h = ctx.enqueue_create_host_buffer[float_dtype](vector_size)
    rhs_h = ctx.enqueue_create_host_buffer[float_dtype](vector_size)
    out_h = ctx.enqueue_create_host_buffer[float_dtype](vector_size)

    # Initialize inputs.
    for i in range(vector_size):
        lhs_h[i] = Float32(i)
        rhs_h[i] = Float32(i) * 0.5

    # Optional: show that the inputs are initialized correctly.
    # (The previous compiled binary printed these; keep it in-source too.)
    print("LHS:", lhs_h)
    print("RHS:", rhs_h)

    # Allocate buffers on the device.
    lhs = ctx.enqueue_create_buffer[float_dtype](vector_size)
    rhs = ctx.enqueue_create_buffer[float_dtype](vector_size)
    out_ = ctx.enqueue_create_buffer[float_dtype](vector_size)

    # Copy inputs to device.
    lhs_h.enqueue_copy_to(lhs)
    rhs_h.enqueue_copy_to(rhs)

    # Wrap the device buffers with LayoutTensor views.
    lhs_t = LayoutTensor[float_dtype, layout](lhs)
    rhs_t = LayoutTensor[float_dtype, layout](rhs)
    out_t = LayoutTensor[float_dtype, layout](out_)

    # Enqueue the vector addition
    ctx.enqueue_function[vector_addition, vector_addition](
        lhs_t, rhs_t, out_t,
        grid_dim=(num_blocks, 1, 1),
        block_dim=(block_size, 1, 1),
    )

    # Copy result back to host for printing/checking.
    out_.enqueue_copy_to(out_h)

    # Synchronize to run all enqueued operations
    ctx.synchronize()

    # Print a small slice of the vectors.
    show = 10
    print("First {} elements:".format(show))
    for i in range(show):
        print(
            "i={}: lhs={} rhs={} out={}".format(
                i, lhs_h[i], rhs_h[i], out_h[i]
            )
        )

    # Simple correctness check.
    max_abs_err = Float32(0)
    for i in range(vector_size):
        expected = lhs_h[i] + rhs_h[i]
        err = abs(out_h[i] - expected)
        if err > max_abs_err:
            max_abs_err = err
    print("max_abs_err = {}".format(max_abs_err))

    # Non-zero exit to make CI/scripting easy.
    if max_abs_err != 0:
        exit(2)

