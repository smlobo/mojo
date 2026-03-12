
fn sum(*values: Int) -> Int:
    var sum: Int = 0
    for value in values:
        sum = sum + value
    return sum

fn main():
    print("1 + 2 = {}".format(sum(1, 2)))
    print("1 + 2 + 3 = {}".format(sum(1, 2, 3)))


