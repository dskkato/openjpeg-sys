use std::path::Path;

fn main() {
    let jp2dir = Path::new("vendor");
    cmake::build(jp2dir);

}
