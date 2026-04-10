@value
struct SearchResult:
    var id: UInt64
    var distance: Float32
    var score: Float32  # 1.0 - distance or similar, depending on metric

@value
struct IndexConfig:
    var dimension: Int
    var max_elements: Int
    var m: Int
    var ef_construction: Int
    var ef_search: Int

    fn __init__(out self, dimension: Int, max_elements: Int = 10000, m: Int = 16, ef_construction: Int = 200, ef_search: Int = 50):
        self.dimension = dimension
        self.max_elements = max_elements
        self.m = m
        self.ef_construction = ef_construction
        self.ef_search = ef_search

@value
struct MetricType:
    var value: UInt8
    
    alias COSINE = MetricType(0)
    alias EUCLIDEAN = MetricType(1)
    alias DOT_PRODUCT = MetricType(2)
