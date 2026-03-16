
fn main():
    for i in range(5):
        print(i, end=", ")
    else:
        print("\nFinished executing 'for' loop")

    var empty: List[Int] = []
    for i in empty:
        print(i)
    else:
        print("Finished executing (empty) 'for' loop")

    animals = ["cat", "aardvark", "hippopotamus", "dog"]
    for animal in animals:
        print(t"{animal}", end=", ")
        if animal == "dog":
            print("\n\tFound a dog")
            break
    else:
        print("No dog found")

