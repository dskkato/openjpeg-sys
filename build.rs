use std::path::Path;

fn main() {
    let mut cc = cc::Build::new();
    let jp2dir = Path::new("vendor/src/lib/openjp2");

    cc.include(jp2dir);
    cc.include("config");
    cc.define("OPJ_STATIC", Some("1"));

    let files = [
        "thread.c",
        "bio.c",
        "cio.c",
        "dwt.c",
        "event.c",
        "image.c",
        "invert.c",
        "j2k.c",
        "jp2.c",
        "mct.c",
        "mqc.c",
        "openjpeg.c",
        "opj_clock.c",
        "pi.c",
        "t1.c",
        "t2.c",
        "tcd.c",
        "tgt.c",
        "function_list.c",
        "opj_malloc.c",
        "sparse_array.c",
    ];
    for file in files.iter() {
        cc.file(jp2dir.join(file));
    }
    cc.compile("openjp2");
}
