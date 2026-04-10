from .base import VectorIndex
from ..core.vector import EmbeddingVector
from ..core.types import SearchResult, IndexConfig, MetricType
from ..core.errors import dimension_mismatch, not_found_error
from ..distance.metrics import CosineDistance, EuclideanDistance, DotProductDistance

struct BruteForceIndex(VectorIndex):
    var config: IndexConfig
    var vectors: List[EmbeddingVector]
    var metric: MetricType
    
    fn __init__(out self, config: IndexConfig, metric: MetricType):
        self.config = config
        self.metric = metric
        self.vectors = List[EmbeddingVector](capacity=config.max_elements)
        
    fn insert(inout self, vector: EmbeddingVector) raises:
        if vector.dim != self.config.dimension:
            raise dimension_mismatch(self.config.dimension, vector.dim)
        
        # In a real implementation we would copy the vector or take ownership
        # Here we just keep a copy of it
        self.vectors.append(vector)
        
    fn search(self, query: EmbeddingVector, k: Int) raises -> List[SearchResult]:
        if query.dim != self.config.dimension:
            raise dimension_mismatch(self.config.dimension, query.dim)
            
        var results = List[SearchResult](capacity=len(self.vectors))
        
        for i in range(len(self.vectors)):
            var dist: Float32 = 0.0
            if self.metric == MetricType.COSINE:
                dist = CosineDistance.compute(self.vectors[i], query)
            elif self.metric == MetricType.EUCLIDEAN:
                dist = EuclideanDistance.compute(self.vectors[i], query)
            else:
                dist = DotProductDistance.compute(self.vectors[i], query)
                
            results.append(SearchResult(id=self.vectors[i].id, distance=dist, score=1.0-dist))
            
        # In a real implementation we would sort the list and keep top K, or use a min-heap
        # Simple placeholder for sorting logic:
        # TODO: Implement proper top-K selection (min-heap)
        
        return results

    fn remove(inout self, id: UInt64) raises:
        for i in range(len(self.vectors)):
            if self.vectors[i].id == id:
                # Remove logic (move last to current, pop last)
                var last_idx = len(self.vectors) - 1
                self.vectors[i] = self.vectors[last_idx]
                _ = self.vectors.pop()
                return
        raise not_found_error(id)
        
    fn size(self) -> Int:
        return len(self.vectors)
        
    fn dimension(self) -> Int:
        return self.config.dimension
