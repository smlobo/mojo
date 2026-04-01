from std.collections import Set

fn compileTimeIterator():
    print("compileTimeIterator: (", end="")
    comptime for i in range(10, 20, 2):
        print(i, end=", ")
    print(")")

fn runTimeIterator():
    var nameSet: Set[String] = Set[String]()
    nameSet.add("Anu")
    nameSet.add("Bindu")
    nameSet.add("Chandni")
    print("runTimeIterator: (", end="")
    # Set is mutable, so cannot use comptime
    for name in nameSet:
        print(name, end=", ")
    print(")")

fn main():
    compileTimeIterator()
    runTimeIterator()

