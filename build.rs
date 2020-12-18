fn main() {
    let dst = cmake::Config::new("vendor")
        .define("BUILD_SHARED_LIBS", "off")
        .build();

    println!("cargo:rerun-if-changed=build.rs");
    println!("cargo:rustc-link-search={}/lib", dst.display());
    if cfg!(target_os = "windows") {
        println!("cargo:rustc-link-lib=openjp2");
    } else {
        println!("cargo:rustc-link-lib=static=openjp2");
    }
}
