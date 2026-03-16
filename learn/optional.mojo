
fn main():
    var custom_greeting: Optional[String] = None
    print(custom_greeting.or_else("Hello"))

    custom_greeting = "Hi"
    print(custom_greeting.or_else("Hello"))

