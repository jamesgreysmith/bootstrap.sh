# bootstrap.sh
A really simple quick-and-dirty shell scipt that builds a GCC toolchain

Currently this only builds a stage 1 cross compiler targeting i686-elf, in it's current state it expects to be in a subdirectory called `tools`, and outputs the results into the directory `../cross`.

To use on most Unix-like platforms just...
`export PATH="${TARGET_PREFIX}/bin:${PATH}"`
`export LD_LIBRARY_PATH="${TARGET_PREFIX}/lib:${LD_LIBRARY_PATH}"`
`export PKG_CONFIG_PATH="${TARGET_PREFIX}/lib/pkgconfig"`
where TARGET_PREFIX is your working directory+cross/[target]

Only tested on bash but it be compatible with others too.