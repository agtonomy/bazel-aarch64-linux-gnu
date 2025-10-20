load("@aarch64_linux_gnu//toolchain:config.bzl", "cc_linux_gnu_config")

package(default_visibility = ["//visibility:public"])

compiler = "ubuntu-22.04-x86_64-native"

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
        "x86_64-linux-gnu-gcc",
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "x86_64-linux-gnu-gcc",
        "x86_64-linux-gnu-ld",
        "@{}//:ar".format(compiler),
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
        "@{}//:ld".format(compiler),
    ],
)

filegroup(
    name = "ar_files",
    srcs = [
        "x86_64-linux-gnu-ar",
        "@{}//:ar".format(compiler),
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "x86_64-linux-gnu-objcopy",
        "@{}//:objcopy".format(compiler),
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "x86_64-linux-gnu-strip",
        "@{}//:strip".format(compiler),
    ],
)

filegroup(
    name = "x86_64_all_files",
    srcs = [
        ":ar_files",
        ":x86_64_compiler_files",
        ":x86_64_linker_files",
    ]
)

filegroup(
    name = "x86_64_compiler_files",
    srcs = [
        ":compiler_files",
        ":x86_64_compiler_pieces",
    ],
)

filegroup(
    name = "x86_64_linker_files",
    srcs = [
        ":x86_64_compiler_pieces",
        ":linker_files",
    ],
)

filegroup(
    name = "x86_64_compiler_pieces",
    srcs = [
        "@linux-libc-5.15.0-x86_64//:headers",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

cc_linux_gnu_config(
    name = "x86_64_config",
    gcc_repo = compiler,
    gcc_version = "11",
    host_system_name = "linux_x86_64",
    target_system_name = "linux_x86_64",
    target_cpu = "k8",
    include_paths = [
        "usr/lib/gcc/x86_64-linux-gnu/11/include/",
        "usr/include/x86_64-linux-gnu/",
        "usr/include/c++/11/",
        "usr/include/x86_64-linux-gnu/c++/11/",
        "usr/include/",
        "external/{}/usr/include/".format("linux-libc-5.15.0-x86_64"),
        "external/{}/usr/include/x86_64-linux-gnu/".format("linux-libc-5.15.0-x86_64"),
    ],
    toolchain_identifier = "ubuntu-22.04-x86_64-native",
    wrapper_path = "ubuntu-22.04-native/linux_x86_64/x86_64-linux-gnu-",
)
