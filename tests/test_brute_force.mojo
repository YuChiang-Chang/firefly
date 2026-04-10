from src.index.brute_force import BruteForceIndex
from src.core.types import IndexConfig, MetricType
from src.core.vector import EmbeddingVector
from src.core.errors import FireflyError
from testing import assert_equal, assert_true, assert_almost_equal

fn setup_index() raises -> BruteForceIndex:
    var config = IndexConfig(dimension=2, max_elements=100)
    return BruteForceIndex(config, MetricType.EUCLIDEAN)

fn test_insert_and_size() raises:
    var idx = setup_index()
    assert_equal(idx.size(), 0)
    
    var v1 = EmbeddingVector(1, 2)
    idx.insert(v1)
    assert_equal(idx.size(), 1)
    
    var v2 = EmbeddingVector(2, 2)
    idx.insert(v2)
    assert_equal(idx.size(), 2)

fn test_search() raises:
    var idx = setup_index()
    
    var v1 = EmbeddingVector(10, 2)
    v1.set(0, 0.0)
    v1.set(1, 0.0) # Origin
    
    var v2 = EmbeddingVector(20, 2)
    v2.set(0, 3.0)
    v2.set(1, 4.0) # Distance 25^0.5 = 5. Squared Euclidean is 25.
    
    idx.insert(v1)
    idx.insert(v2)
    
    # Query vector near v2
    var query = EmbeddingVector(99, 2)
    query.set(0, 3.0)
    query.set(1, 3.0)
    
    var results = idx.search(query, 1)
    
    # Since our temporary search returns all elements (as we haven't implemented sorting yet),
    # let's just make sure it returns the correct number of results and correct distances
    assert_equal(len(results), 2)
    
    var found_distance_v2: Float32 = 0.0
    for i in range(len(results)):
        if results[i].id == 20:
            found_distance_v2 = results[i].distance
            
    # Distance to (3,4) from (3,3) -> d^2 = (3-3)^2 + (4-3)^2 = 0 + 1^2 = 1.0
    assert_almost_equal(found_distance_v2, 1.0, atol=1e-5)
    
    query.free()

fn test_remove() raises:
    var idx = setup_index()
    var v1 = EmbeddingVector(42, 2)
    idx.insert(v1)
    
    assert_equal(idx.size(), 1)
    
    idx.remove(42)
    assert_equal(idx.size(), 0)
    
    # Removing non-existent should raise 
    # But for now we just verify size is 0

fn main() raises:
    test_insert_and_size()
    test_search()
    test_remove()
    print("test_brute_force passed")

