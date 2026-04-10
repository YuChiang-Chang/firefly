from src.core.vector import EmbeddingVector
from src.distance.metrics import CosineDistance, EuclideanDistance, DotProductDistance
from testing import assert_equal, assert_true, assert_almost_equal

fn test_dot_product() raises:
    var dim = 8  # Use small dimension to easily verify manually
    var v1 = EmbeddingVector(1, dim)
    var v2 = EmbeddingVector(2, dim)
    
    # Init some values
    for i in range(dim):
        v1.set(i, 1.0)
        v2.set(i, 2.0)
        
    var dp_dist = DotProductDistance.compute(v1, v2)
    # 8 elements of (1.0 * 2.0 = 2.0) -> sum = 16.0
    # Our DotProductDistance returns NEGATIVE dot product for min-heap compatibility
    assert_almost_equal(dp_dist, -16.0, atol=1e-5)
    
    v1.free()
    v2.free()

fn test_euclidean() raises:
    var dim = 4
    var v1 = EmbeddingVector(1, dim)
    var v2 = EmbeddingVector(2, dim)
    
    v1.set(0, 0.0)
    v1.set(1, 0.0)
    v1.set(2, 0.0)
    v1.set(3, 0.0)

    v2.set(0, 1.0)
    v2.set(1, 2.0)
    v2.set(2, 2.0)
    v2.set(3, 0.0)
    # Euclidean distance squared: 1^2 + 2^2 + 2^2 = 1 + 4 + 4 = 9
    var eu_dist = EuclideanDistance.compute(v1, v2)
    assert_almost_equal(eu_dist, 9.0, atol=1e-5)
    
    v1.free()
    v2.free()

fn test_cosine() raises:
    var dim = 2
    var v1 = EmbeddingVector(1, dim)
    var v2 = EmbeddingVector(2, dim)
    
    # (1, 0) and (0, 1) -> orthogonal -> cosine similarity 0 -> cosine distance 1.0
    v1.set(0, 1.0)
    v1.set(1, 0.0)
    
    v2.set(0, 0.0)
    v2.set(1, 1.0)
    
    var cos_dist = CosineDistance.compute(v1, v2)
    assert_almost_equal(cos_dist, 1.0, atol=1e-5)
    
    # (1, 0) and (1, 0) -> parallel -> cosine similarity 1.0 -> distance 0.0
    v2.set(0, 1.0)
    v2.set(1, 0.0)
    cos_dist = CosineDistance.compute(v1, v2)
    assert_almost_equal(cos_dist, 0.0, atol=1e-5)
    
    v1.free()
    v2.free()

fn test_large_simd_width() raises:
    # Test a dimension size that is large and not a perfect multiple of SIMD width (e.g. 5)
    var dim = 125
    var v1 = EmbeddingVector(1, dim)
    var v2 = EmbeddingVector(2, dim)
    
    for i in range(dim):
        v1.set(i, 1.0)
        v2.set(i, 1.0)
        
    var dp_dist = DotProductDistance.compute(v1, v2)
    assert_almost_equal(dp_dist, -125.0, atol=1e-5)
    
    v1.free()
    v2.free()

fn main() raises:
    test_dot_product()
    test_euclidean()
    test_cosine()
    test_large_simd_width()
    print("test_distance passed")

