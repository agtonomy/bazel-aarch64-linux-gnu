# toolchains/ubuntu-22.04-native.BUILD

# Uses globs to capture x86_64 and aarch64 files

package(default_visibility = ["//visibility:public"])

# export the executable files to make them available for direct use.
exports_files(glob(["usr/bin/*"]))

# gcc executables.
filegroup(
    name = "gcc",
    srcs = glob(["usr/bin/*-linux-gnu-gcc*"]),
)

# ar executables.
filegroup(
    name = "ar",
    srcs = glob([
            "usr/bin/*-linux-gnu-ar*",
            "usr/bin/*-linux-gnu-gcc-ar*",
        ]),
)

# ld executables.
filegroup(
    name = "ld",
    srcs = glob(["usr/bin/*-linux-gnu-ld*"]),
)

# nm executables.
filegroup(
    name = "nm",
    srcs = glob([
            "usr/bin/*-linux-gnu-nm*",
            "usr/bin/*-linux-gnu-gcc-nm*",
        ]),
)

# objcopy executables.
filegroup(
    name = "objcopy",
    srcs = glob(["usr/bin/*-linux-gnu-objcopy*"]),
)

# objdump executables.
filegroup(
    name = "objdump",
    srcs = glob(["usr/bin/*-linux-gnu-objdump*"]),
)

# strip executables.
filegroup(
    name = "strip",
    srcs = glob(["usr/bin/*-linux-gnu-strip*"]),
)

# as executables.
filegroup(
    name = "as",
    srcs = glob(["usr/bin/*-linux-gnu-as*"]),
)

# size executables.
filegroup(
    name = "size",
    srcs = glob(["usr/bin/*-linux-gnu-size*"]),
)

# libraries and headers.
filegroup(
    name = "compiler_pieces",
    srcs = [
        ":headers",
        ":libraries",
    ],
)

filegroup(
    name = "headers",
    srcs = glob([
        "usr/include/**/*.h",
        "usr/include/*.h",
        "usr/include/c++/**",
        "usr/lib/gcc/*-linux-gnu/11/include/**/*.h",
    ]),
)

filegroup(
    name = "libraries",
    srcs = glob([
        "usr/lib/*-linux-gnu/**/*.so*",
        "usr/lib/*-linux-gnu/*.a",
        "usr/lib/gcc/*-linux-gnu/11/*.a",
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
