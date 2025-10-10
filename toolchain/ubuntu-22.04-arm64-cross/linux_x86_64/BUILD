load("@aarch64_linux_gnu//toolchain:config.bzl", "cc_aarch64_linux_gnu_config")

package(default_visibility = ["//visibility:public"])

compiler = "ubuntu-22.04-arm64-cross"

filegroup(
    name = "all_files",
    srcs = [
        ":ar_files",
        ":compiler_files",
        ":linker_files",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

filegroup(
    name = "compiler_files",
    srcs = [
        "aarch64-linux-gnu-gcc",
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "aarch64-linux-gnu-gcc",
        "aarch64-linux-gnu-ld",
        "@{}//:ar".format(compiler),
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
        "@{}//:ld".format(compiler),
    ],
)

filegroup(
    name = "ar_files",
    srcs = [
        "aarch64-linux-gnu-ar",
        "@{}//:ar".format(compiler),
        "@{}//:host_libraries".format(compiler),
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "aarch64-linux-gnu-objcopy",
        "@{}//:host_libraries".format(compiler),
        "@{}//:objcopy".format(compiler),
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "aarch64-linux-gnu-strip",
        "@{}//:host_libraries".format(compiler),
        "@{}//:strip".format(compiler),
    ],
)

filegroup(
    name = "jp62_all_files",
    srcs = [
        ":ar_files",
        ":jp62_compiler_files",
        ":jp62_linker_files",
    ]
)

filegroup(
    name = "jp62_compiler_files",
    srcs = [
        ":compiler_files",
        ":jp62_compiler_pieces",
    ],
)

filegroup(
    name = "jp62_linker_files",
    srcs = [
        ":jp62_compiler_pieces",
        ":linker_files",
    ],
)

filegroup(
    name = "jp62_compiler_pieces",
    srcs = [
        "@linux-libc-5.15.0//:headers",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

filegroup(
    name = "jp512_all_files",
    srcs = [
        ":ar_files",
        ":jp512_compiler_files",
        ":jp512_linker_files",
    ]
)

filegroup(
    name = "jp512_compiler_files",
    srcs = [
        ":compiler_files",
        ":jp512_compiler_pieces",
    ],
)

filegroup(
    name = "jp512_linker_files",
    srcs = [
        ":jp512_compiler_pieces",
        ":linker_files",
    ],
)

filegroup(
    name = "jp512_compiler_pieces",
    srcs = [
        "@linux-libc-5.4.0//:headers",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

cc_aarch64_linux_gnu_config(
    name = "jp62_config",
    gcc_repo = compiler,
    gcc_version = "11",
    host_system_name = "linux_x86_64",
    include_paths = [
        "usr/lib/gcc-cross/aarch64-linux-gnu/11/include/",
        "usr/aarch64-linux-gnu/include/c++/11/",
        "usr/aarch64-linux-gnu/include/c++/11/aarch64-linux-gnu",
        "usr/aarch64-linux-gnu/include/",
        "external/{}/usr/aarch64-linux-gnu/include/".format("linux-libc-5.15.0"),
    ],
    toolchain_identifier = "ubuntu-22.04-arm64-cross",
    wrapper_path = "ubuntu-22.04-arm64-cross/linux_x86_64/aarch64-linux-gnu-",
)

cc_aarch64_linux_gnu_config(
    name = "jp512_config",
    gcc_repo = compiler,
    gcc_version = "11",
    host_system_name = "linux_x86_64",
    include_paths = [
        "usr/lib/gcc-cross/aarch64-linux-gnu/11/include/",
        "usr/aarch64-linux-gnu/include/c++/11/",
        "usr/aarch64-linux-gnu/include/c++/11/aarch64-linux-gnu",
        "usr/aarch64-linux-gnu/include/",
        "external/{}/usr/aarch64-linux-gnu/include/".format("linux-libc-5.4.0"),
    ],
    toolchain_identifier = "ubuntu-22.04-arm64-cross",
    wrapper_path = "ubuntu-22.04-arm64-cross/linux_x86_64/aarch64-linux-gnu-",
)
