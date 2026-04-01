
struct Point(Writable):
    var x: Float32
    var y: Float32

    fn __init__(out self, x: Float32, y: Float32):
        print(t"Constructor: {x}, {y}")
        self.x = x
        self.y = y

    fn __del__(deinit self):
        print(t"Implicit destructor: {self}")

    fn write_to(self, mut writer: Some[Writer]):
        writer.write("<{}, {}>".format(self.x, self.y))

fn main():
    var p1 = Point(1.1, 2.2)
    print(t"p1 = {p1}")

