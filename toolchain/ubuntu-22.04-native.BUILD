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

# Every file gcc and ld reach at action time. Under remote execution an action
# only sees the inputs it declares, so this deliberately globs whole directories
# instead of matching *.so*/*.a: those two patterns miss gcc's extensionless
# internals (cc1, cc1plus, collect2, lto1, lto-wrapper), the CRT objects
# (crt1.o, crti.o, crtn.o, Scrt1.o, crtbegin.o, crtend.o), gcc's *.spec files,
# and ld's linker scripts (ldscripts/, and the text scripts named libc.so /
# libpthread.so).
filegroup(
    name = "libraries",
    srcs = glob([
        "usr/lib/*-linux-gnu/**",
        "usr/lib/gcc/*-linux-gnu/11/**",
        # The archives keep Ubuntu's merged-/usr layout, where the top-level
        # lib/ and lib64/ are symlinks into usr/. glibc's ld scripts name the
        # /lib spelling -- libc.so is
        # GROUP(/lib/x86_64-linux-gnu/libc.so.6 ... AS_NEEDED(/lib64/ld-linux-x86-64.so.2))
        # -- and ld resolves those against --sysroot, so the shared libraries
        # they reach for have to be declared under that spelling too.
        "lib/*-linux-gnu/*.so*",
        "lib64/*.so*",
        "usr/lib64/*.so*",
    ]),
)

# Shared libraries required to execute compiler binaries on the host system:
filegroup(
    name = "host_libraries",
    srcs = glob(["host-libs/**"]),
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
