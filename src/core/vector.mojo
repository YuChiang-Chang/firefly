from memory import UnsafePointer

struct EmbeddingVector(Copyable, Movable):
    var id: UInt64
    var dim: Int
    var data: UnsafePointer[Float32]
    
    fn __init__(out self, id: UInt64, dim: Int):
        self.id = id
        self.dim = dim
        self.data = UnsafePointer[Float32].alloc(dim)
        # Initialize with zeros
        for i in range(dim):
            self.data[i] = 0.0
            
    fn __init__(out self, id: UInt64, dim: Int, data_ptr: UnsafePointer[Float32]):
        self.id = id
        self.dim = dim
        self.data = UnsafePointer[Float32].alloc(dim)
        for i in range(dim):
            self.data[i] = data_ptr[i]

    fn __copyinit__(out self, existing: Self):
        self.id = existing.id
        self.dim = existing.dim
        self.data = UnsafePointer[Float32].alloc(existing.dim)
        for i in range(existing.dim):
            self.data[i] = existing.data[i]

    fn __moveinit__(out self, deinit existing: Self):
        self.id = existing.id
        self.dim = existing.dim
        self.data = existing.data
        # Nullify the existing pointer so it doesn't get double freed
        # Wait, there's no explicitly null pointer easily set to an allocated pointer without uninitialized memory in 2026, 
        # so let's just make it a zero allocation or rely on lifecycle if not explicitly freeing in __del__.
        # Wait, if we don't have a __del__ method, who frees? We should add a free() method.

    fn free(mut self):
        self.data.free()

    fn get(self, index: Int) -> Float32:
        return self.data[index]

    fn set(self, index: Int, value: Float32):
        self.data[index] = value
