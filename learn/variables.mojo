
fn main():
    # Variable ownership
    var xIntList: List[Int] = [1, 2, 3]
    for i in xIntList:
        print("{}".format(i), end=", ")
    print()
    # Cannot copy
    # var cIntListCopy =xIntList
    # Copy single value
    var x1Copy: Int = xIntList[1]
    x1Copy += 1
    print("x1Copy = {} [ != xIntList[1]: {}]".format(x1Copy, xIntList[1]))
    # Reference
    ref x2Ref: Int = xIntList[2]
    x2Ref += 1
    print("x2Ref = {} [ == xIntList[2]: {}]".format(x2Ref, xIntList[2]))

