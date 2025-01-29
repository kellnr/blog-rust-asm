extern "C" {
    fn add(a: usize, b: usize) -> usize;
}

extern "C" {
    fn sub(a: usize, b: usize) -> usize;
}

fn main() {
    let result = unsafe { add(3, 2) };
    println!("Result from add: {}", result);

    let result = unsafe { sub(10, 2) };
    println!("Result from sub: {}", result);
}
