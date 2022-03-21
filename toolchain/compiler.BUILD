# toolchains/compiler.BUILD

package(default_visibility = ['//visibility:public'])

# export the executable files to make them available for direct use.
exports_files(glob(["bin/*"]))

# gcc executables.
filegroup(
    name = "gcc",
    srcs = glob(["bin/*-gcc*"]),
)

# ar executables.
filegroup(
    name = "ar",
    srcs = glob(["bin/*-ar*"]),
)

# ld executables.
filegroup(
    name = "ld",
    srcs = glob(["bin/*-ld*"]),
)

# nm executables.
filegroup(
    name = "nm",
    srcs = glob(["bin/*-nm*"]),
)

# objcopy executables.
filegroup(
    name = "objcopy",
    srcs = glob(["bin/*-objcopy*"]),
)

# objdump executables.
filegroup(
    name = "objdump",
    srcs = glob(["bin/*-objdump*"]),
)

# strip executables.
filegroup(
    name = "strip",
    srcs = glob(["bin/*-strip*"]),
)

# as executables.
filegroup(
    name = "as",
    srcs = glob(["bin/*-as*"]),
)

# size executables.
filegroup(
    name = "size",
    srcs = glob(["bin/*-size*"]),
)

# libraries and headers.
filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "aarch64-none-linux-gnu/**",
        "lib/gcc/aarch64-none-linux-gnu/**",
    ]),
)

# collection of executables.
filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":gcc",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)
