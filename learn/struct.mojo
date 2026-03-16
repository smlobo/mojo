
@fieldwise_init
struct MyPair:
    var first: Int
    var second: Int

    def get_sum(self) -> Int:
        return self.first + self.second

    fn increment(mut self):
        self.first += 1
        self.second += 1


fn main() raises:
    var mine = MyPair(6, 8)
    print(mine.get_sum())

    mine.increment()
    print(mine.get_sum())

