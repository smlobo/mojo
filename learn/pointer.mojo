from mymodule import MyPair
from std.memory import Pointer

fn main():
    var mine = MyPair(2, 4)
    mine.dump()
    foos = Pointer(to=mine)
    foo(foos)

fn foo(ptr: Pointer[MyPair]):
    # ptr[].second += 10
    var copyFirst: Int = ptr[].first
    print(t"In foo: first = {copyFirst}")
    var copyPtr: MyPair = ptr[].copy()
    print("In foo: MyPair: ", end="")
    copyPtr.dump()
    ptr[].dump()

