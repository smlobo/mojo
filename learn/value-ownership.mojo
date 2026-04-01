from mymodule import MyPair

fn callee(var calleeOwner: MyPair) -> MyPair:
    calleeOwner.first += 10
    calleeOwner.second += 20
    print("calleeOwner: ", end="")
    calleeOwner.dump()
    # Pass ownership back to main()
    return calleeOwner^

fn main():
    var owner1 = MyPair(100, 200)
    print("owner1: ", end="")
    owner1.dump()

    # Pass ownership to callee()
    var newCallerOwner: MyPair = callee(owner1^)
    newCallerOwner.first += 1
    newCallerOwner.second += 2
    print("newCallerOwner: ", end="")
    newCallerOwner.dump()

