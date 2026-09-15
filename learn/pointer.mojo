from mymodule import MyPair
from std.memory import Pointer

def main():
    var mine = MyPair(2, 4)
    mine.dump()
    var foos = Pointer(to=mine)
    foo(foos)

def foo(ptr: Pointer[MyPair, _]):
    # ptr[].second += 10
    var copyFirst: Int = ptr[].first
    print(t"In foo: first = {copyFirst}")
    var copyPtr: MyPair = ptr[].copy()
    print("In foo: MyPair: ", end="")
    copyPtr.dump()
    ptr[].dump()

