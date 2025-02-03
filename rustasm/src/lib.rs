#![allow(dead_code)]

use std::ffi::c_char;

extern "C" {
    fn sub(a: u64, b: u64) -> u64;
    fn add(a: u64, b: u64) -> u64;
    fn upp(str: *const c_char);
}

#[cfg(test)]
mod tests {
    use std::ffi::CString;

    use super::*;

    #[test]
    fn test_add() {
        let result = unsafe { add(3, 2) };
        assert_eq!(result, 5);
    }

    #[test]
    fn test_sub() {
        let result = unsafe { sub(10, 2) };
        assert_eq!(result, 8);
    }

    #[test]
    fn test_upp() {
        let c_str = CString::new("HeLlO WoRlD 123!").unwrap();
        let ptr = c_str.into_raw();

        unsafe { upp(ptr) };

        let c_str = unsafe { CString::from_raw(ptr) };
        assert_eq!(c_str.to_str().unwrap(), "HELLO WORLD 123!");
    }
}
