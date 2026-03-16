
fn main():
    simd1 = SIMD[DType.float32, 4](2.2, 3.3, 4.4, 5.5)
    simd2 = SIMD[DType.int16, 4](-1, 2, -3, 4)
    simd3 = simd1 * simd2.cast[DType.float32]()  # Convert with cast() method
    print("simd3:", simd3)
    simd4 = simd2 + SIMD[DType.int16, 4](simd1)  # Convert with SIMD constructor
    print("simd4:", simd4)

