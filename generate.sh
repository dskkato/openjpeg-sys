#!/bin/bash
set -uex

# Blacklist setting
#
# Types
# ------
# - "fftw.*_complex"
#   - Use `num_complex::Complex32` and `num_complex::Complex64`
# - "FILE"
#   - Use `libc::FILE` instead
# - "_.*"
#   - Remove unrelated
#
# Function
# ---------
# - "fftwl_.*"
#   - Disable `long double` interface
#

bindgen \
  --opaque-type=FILE \
  --distrust-clang-mangling \
  --no-layout-tests \
  --whitelist-type='^opj.*' \
  --whitelist-var='^OPJ.*' \
  --whitelist-function='^opj.*' \
  --blacklist-type='_.*' \
  --blacklist-function='_.*' \
  --rustified-enum='.*' \
 vendor/src/lib/openjp2/openjpeg.h -- -Ivendor/src/src/lib/openjp2/ -Iconfig/ |
  sed -E 's/pub type FILE.*/use libc::FILE;/;
  s/\s*@param +([^ ]+)/* `\1` — /;
  s/\s*@return +([^ ]+)/\\n`\1` — /;
  s/pub type OPJ_BYTE.*/pub type OPJ_BYTE = u8;/;
  2s/^/use std::os::raw::*;/;
  s/::std::os::raw:://g' > src/ffi.rs
