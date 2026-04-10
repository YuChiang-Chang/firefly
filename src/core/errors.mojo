@value
struct FireflyError(Error):
    var message: String

    fn __init__(out self, message: String):
        self.message = message

    fn __str__(self) -> String:
        return self.message

fn dimension_mismatch(expected: Int, actual: Int) -> FireflyError:
    return FireflyError("Dimension mismatch: expected " + str(expected) + ", but got " + str(actual))

fn index_full_error() -> FireflyError:
    return FireflyError("Index is full")

fn not_found_error(id: UInt64) -> FireflyError:
    return FireflyError("Vector ID not found: " + str(id))
