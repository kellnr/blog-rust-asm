extern "C" {
    fn add(a: usize, b: usize) -> usize;
}

fn main() {
    let result = unsafe { add(2, 2) };
    println!("Result from c_add: {}", result);
}
