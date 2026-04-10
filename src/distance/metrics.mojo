from ..core.vector import EmbeddingVector
from .simd_ops import simd_dot_product, simd_euclidean_sq, simd_magnitude_sq
from math import sqrt

trait DistanceMetric:
    @staticmethod
    fn compute(a: EmbeddingVector, b: EmbeddingVector) -> Float32: ...
    
    @staticmethod
    fn name() -> String: ...

struct CosineDistance(DistanceMetric):
    @staticmethod
    fn compute(a: EmbeddingVector, b: EmbeddingVector) -> Float32:
        var dot = simd_dot_product(a.data, b.data, a.dim)
        var mag_a_sq = simd_magnitude_sq(a.data, a.dim)
        var mag_b_sq = simd_magnitude_sq(b.data, b.dim)
        if mag_a_sq == 0.0 or mag_b_sq == 0.0:
            return 1.0 # Max distance if one is zero vector
        var mag_product = sqrt(mag_a_sq * mag_b_sq)
        return 1.0 - (dot / mag_product)
        
    @staticmethod
    fn name() -> String:
        return "cosine"

struct EuclideanDistance(DistanceMetric):
    @staticmethod
    fn compute(a: EmbeddingVector, b: EmbeddingVector) -> Float32:
        # Returning squared euclidean distance for efficiency (monotonic)
        return simd_euclidean_sq(a.data, b.data, a.dim)
        
    @staticmethod
    fn name() -> String:
        return "euclidean"

struct DotProductDistance(DistanceMetric):
    @staticmethod
    fn compute(a: EmbeddingVector, b: EmbeddingVector) -> Float32:
        # Negative dot product so smaller is "closer" for min-heap compatibility
        return -simd_dot_product(a.data, b.data, a.dim)
        
    @staticmethod
    fn name() -> String:
        return "dot_product"
