from sys import has_accelerator, exit

from gpu.host import DeviceContext
from gpu import block_idx, thread_idx

# Vector data type and size
comptime float_dtype = DType.float32
comptime vector_size = 1000

fn print_threads():
    """Print thread IDs."""

    print("Block index: [",
        block_idx.x, block_idx.y, block_idx.z,
        "]\tThread index: [",
        thread_idx.x, thread_idx.y, thread_idx.z,
        "]"
    )

def main():
    @parameter
    if not has_accelerator():
        print("No compatible GPU found")
        exit(1)

    # GPU device
    ctx = DeviceContext()
    print("Found GPU:", ctx.name())

    # Play with threads
    ctx.enqueue_function[print_threads, print_threads](
        grid_dim=(2, 2, 1), block_dim=(16, 4, 2)
    )
    ctx.synchronize()
    print("Program finished")

