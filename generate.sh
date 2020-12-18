#!/bin/bash
bindgen --opaque-type=FILE --distrust-clang-mangling  --no-layout-tests --rustified-enum='.*' \
 vendor/src/lib/openjp2/openjpeg.h -- -Ivendor/src/src/lib/openjp2/ -Iconfig/ |
  sed -E 's/pub type FILE.*/use libc::FILE;/;
  s/\s*@param +([^ ]+)/* `\1` — /;
  s/\s*@return +([^ ]+)/\\n`\1` — /;
  s/pub type OPJ_BYTE.*/pub type OPJ_BYTE = u8;/;
  2s/^/use std::os::raw::*;/;
  s/::std::os::raw:://g' > src/ffi.rs
