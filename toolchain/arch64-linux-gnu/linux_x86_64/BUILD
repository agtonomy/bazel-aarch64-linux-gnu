# toolchains/aarch64-linux-gnu/linux/BUILD.bazel

load("@aarch64_linux_gnu//toolchain:config.bzl", "cc_aarch64_linux_gnu_config")

package(default_visibility = ["//visibility:public"])

compiler = "aarch64_linux_gnu_linux_x86_64"

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

cc_aarch64_linux_gnu_config(
    name = "config",
    gcc_repo = compiler,
    gcc_version = "9.2.1",
    host_system_name = "linux_x86_64",
    toolchain_identifier = "aarch64_linux_gnu_linux_x86_64",
    wrapper_path = "aarch64-linux-gnu/linux_x86_64",
)
