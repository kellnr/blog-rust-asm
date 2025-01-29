use std::path::{Path, PathBuf};
use std::process::Command;
use std::{env, fs};

fn main() {
    // Tell cargo to rerun this build script if the math.s file changed
    println!("cargo:rerun-if-changed=../libasm/math.s");

    // Build the assembly file to a dylib
    let _output = Command::new("make")
        .arg("dylib")
        .current_dir("../libasm")
        .output()
        .expect("Failed to build dylib");

    // Link the library to the rust executable
    let libdir_path = PathBuf::from("../libasm")
        .canonicalize()
        .expect("cannot canonicalize library path");
    copy_dylib_to_target_dir(&libdir_path, "libMath.dylib");
    println!("cargo:rustc-link-search={}", env::var("OUT_DIR").unwrap());
    println!(
        "cargo:rustc-link-arg=-Wl,-rpath,{}",
        env::var("OUT_DIR").unwrap()
    );
    println!("cargo:rustc-link-lib=Math");
}

fn copy_dylib_to_target_dir(lib_dir: &Path, dylib: &str) {
    let out_dir = env::var("OUT_DIR").unwrap();
    let dst = Path::new(&out_dir);
    let _ = fs::copy(lib_dir.join(dylib), dst.join(dylib));
}
