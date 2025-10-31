load("@aarch64_linux_gnu//toolchain:config.bzl", "cc_linux_gnu_config")

package(default_visibility = ["//visibility:public"])

compiler = "ubuntu-22.04-aarch64-native"

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
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "aarch64-linux-gnu-objcopy",
        "@{}//:objcopy".format(compiler),
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "aarch64-linux-gnu-strip",
        "@{}//:strip".format(compiler),
    ],
)

filegroup(
    name = "aarch64_all_files",
    srcs = [
        ":ar_files",
        ":aarch64_compiler_files",
        ":aarch64_linker_files",
    ]
)

filegroup(
    name = "aarch64_compiler_files",
    srcs = [
        ":compiler_files",
        ":aarch64_compiler_pieces",
    ],
)

filegroup(
    name = "aarch64_linker_files",
    srcs = [
        ":aarch64_compiler_pieces",
        ":linker_files",
    ],
)

filegroup(
    name = "aarch64_compiler_pieces",
    srcs = [
        "@linux-libc-5.15.0-aarch64//:headers",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

# Set of files with Jetpack 5.1.2 linux-libc headers:
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
        "@linux-libc-5.4.0-aarch64//:headers",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

cc_linux_gnu_config(
    name = "aarch64_config",
    gcc_repo = compiler,
    gcc_version = "11",
    host_system_name = "linux_aarch64",
    include_paths = [ # Path order is important to avoid bazel errors about undeclared files:
        "usr/lib/gcc/aarch64-linux-gnu/11/include/",
        "usr/include/aarch64-linux-gnu/",
        "usr/include/c++/11/",
        "usr/include/aarch64-linux-gnu/c++/11/",
        "usr/include/",
        "external/{}/usr/include/".format("linux-libc-5.15.0-aarch64"),
        "external/{}/usr/include/aarch64-linux-gnu/".format("linux-libc-5.15.0-aarch64"),
    ],
    toolchain_identifier = "ubuntu-22.04-aarch64-native",
    wrapper_path = "ubuntu-22.04-native/linux_aarch64/aarch64-linux-gnu-",
)

cc_linux_gnu_config(
    name = "jp512_config",
    gcc_repo = compiler,
    gcc_version = "11",
    host_system_name = "linux_aarch64",
    include_paths = [ # Path order is important to avoid bazel errors about undeclared files:
        "usr/lib/gcc/aarch64-linux-gnu/11/include/",
        "usr/include/aarch64-linux-gnu/",
        "usr/include/c++/11/",
        "usr/include/aarch64-linux-gnu/c++/11/",
        "usr/include/",
        "external/{}/usr/include/".format("linux-libc-5.4.0-aarch64"),
        "external/{}/usr/include/aarch64-linux-gnu/".format("linux-libc-5.4.0-aarch64"),
    ],
    toolchain_identifier = "ubuntu-22.04-aarch64-native",
    wrapper_path = "ubuntu-22.04-native/linux_aarch64/aarch64-linux-gnu-",
)
