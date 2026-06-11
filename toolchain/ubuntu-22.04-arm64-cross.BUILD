# toolchains/ubuntu-22.04-arm64-cross.BUILD

package(default_visibility = ["//visibility:public"])

# export the executable files to make them available for direct use.
exports_files(glob(["usr/bin/*"]))

# gcc executables.
filegroup(
    name = "gcc",
    srcs = glob(["usr/bin/aarch64-linux-gnu-gcc*"]),
)

# ar executables.
filegroup(
    name = "ar",
    srcs = glob(["usr/bin/aarch64-linux-gnu-ar*"]),
)

# ld executables.
filegroup(
    name = "ld",
    srcs = glob(["usr/bin/aarch64-linux-gnu-ld*"]),
)

# nm executables.
filegroup(
    name = "nm",
    srcs = glob(["usr/bin/aarch64-linux-gnu-nm*"]),
)

# objcopy executables.
filegroup(
    name = "objcopy",
    srcs = glob(["usr/bin/aarch64-linux-gnu-objcopy*"]),
)

# objdump executables.
filegroup(
    name = "objdump",
    srcs = glob(["usr/bin/aarch64-linux-gnu-objdump*"]),
)

# strip executables.
filegroup(
    name = "strip",
    srcs = glob(["usr/bin/aarch64-linux-gnu-strip*"]),
)

# as executables.
filegroup(
    name = "as",
    srcs = glob(["usr/bin/aarch64-linux-gnu-as*"]),
)

# size executables.
filegroup(
    name = "size",
    srcs = glob(["usr/bin/aarch64-linux-gnu-size*"]),
)

# libraries and headers.
filegroup(
    name = "compiler_pieces",
    srcs = [
        ":headers",
        ":host_libraries",
        ":libraries",
    ],
)

filegroup(
    name = "headers",
    srcs = glob([
        "usr/aarch64-linux-gnu/include/**/*.h",
        "usr/aarch64-linux-gnu/include/**/*.hpp",
        "usr/aarch64-linux-gnu/include/c++/**",
        "usr/lib/gcc-cross/aarch64-linux-gnu/11/include/**/*.h",
    ]),
)

filegroup(
    name = "libraries",
    srcs = glob([
        "usr/aarch64-linux-gnu/lib/**/*.so*",
        "usr/aarch64-linux-gnu/lib/*.a",
        "usr/lib/gcc-cross/aarch64-linux-gnu/11/**/*.so*",
        "usr/lib/gcc-cross/aarch64-linux-gnu/11/*.a",
    ]),
)

# Shared libraries required to execute some binaries like gcc and ar
# on the host system:
filegroup(
    name = "host_libraries",
    srcs = glob(["usr/lib/x86_64-linux-gnu/*"]),
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
