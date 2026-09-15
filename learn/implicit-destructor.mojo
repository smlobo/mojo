
struct Point(Writable):
    var x: Float32
    var y: Float32

    def __init__(out self, x: Float32, y: Float32):
        print(t"Constructor: {x}, {y}")
        self.x = x
        self.y = y

    def __deinit__(deinit self):
        print(t"Implicit destructor: {self}")

    def write_to(self, mut writer: Some[Writer]):
        writer.write("<{}, {}>".format(self.x, self.y))

def main():
    var p1 = Point(1.1, 2.2)
    print(t"p1 = {p1}")

