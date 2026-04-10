from memory import UnsafePointer

fn simd_dot_product(a: UnsafePointer[Float32], 
                    b: UnsafePointer[Float32], 
                    dim: Int) -> Float32:
    var result: Float32 = 0.0
    for i in range(dim):
        result += a[i] * b[i]
    return result

fn simd_euclidean_sq(a: UnsafePointer[Float32], 
                     b: UnsafePointer[Float32], 
                     dim: Int) -> Float32:
    var result: Float32 = 0.0
    for i in range(dim):
        var diff = a[i] - b[i]
        result += diff * diff
    return result

fn simd_magnitude_sq(a: UnsafePointer[Float32], dim: Int) -> Float32:
    var result: Float32 = 0.0
    for i in range(dim):
        result += a[i] * a[i]
    return result
