from src.core.vector import EmbeddingVector
from testing import assert_equal, assert_true

fn test_vector_creation() raises:
    var vec = EmbeddingVector(id=1, dim=128)
    assert_equal(vec.id, 1)
    assert_equal(vec.dim, 128)
    
    # Values should all be 0
    for i in range(128):
        assert_equal(vec.get(i), 0.0)
        
    vec.set(0, 1.5)
    assert_equal(vec.get(0), 1.5)
    vec.free()

fn run_all() raises:
    test_vector_creation()
    print("All tests passed.")
    
# When using `mojo test`, tests are discovered automatically if they start with `test_`

fn main() raises:
    run_all()

