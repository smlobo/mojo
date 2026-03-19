from mymodule import MyPair
from std.memory import OwnedPointer

fn main():
    var evenPointer: OwnedPointer[MyPair] = OwnedPointer(MyPair(10, 10))
    var oddPointer: OwnedPointer[MyPair] = evenPointer^
    print("oddPointer initialized to: ", end="")
    oddPointer[].dump()

