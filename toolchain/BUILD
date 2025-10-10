# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain")
load(":config.bzl", "cc_aarch64_linux_gnu_config")

filegroup(
    name = "generic_all_files",
    srcs = [
        ":generic_compiler_files",
        ":generic_linker_files",
        "//toolchain/aarch64-none-linux-gnu/linux_x86_64:ar_files",
    ]
)

filegroup(
    name = "generic_compiler_files",
    srcs = [
        "//toolchain/aarch64-none-linux-gnu/linux_x86_64:compiler_files",
        "@aarch64_linux_gnu_linux_x86_64//:generic_compiler_pieces",
    ],
)

filegroup(
    name = "generic_linker_files",
    srcs = [
        "//toolchain/aarch64-none-linux-gnu/linux_x86_64:linker_files",
        "@aarch64_linux_gnu_linux_x86_64//:generic_compiler_pieces",
    ],
)

# Generic ARM64 on X86_64 Cross Compile Toolchain
cc_toolchain(
    name = "cc_toolchain_linux_x86_64",
    all_files = ":generic_all_files",
    ar_files = "//toolchain/aarch64-none-linux-gnu/linux_x86_64:ar_files",
    compiler_files = ":generic_compiler_files",
    dwp_files = ":empty",
    linker_files = ":generic_linker_files",
    objcopy_files = "//toolchain/aarch64-none-linux-gnu/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/aarch64-none-linux-gnu/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/aarch64-none-linux-gnu/linux_x86_64:config",
    toolchain_identifier = "aarch64_linux_gnu_linux_x86_64",
)

# Ubuntu 22.04 gcc 11 ARM64 on x86_64 Cross Compile Toolchain
cc_toolchain(
    name = "jp62_aarch64_gcc-11_linux_x86_64",
    all_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_all_files",
    ar_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:ar_files",
    compiler_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_linker_files",
    objcopy_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_config",
    toolchain_identifier = "ubuntu-22.04-arm64-cross",
)

# Ubuntu 22.04 gcc 11 ARM64 on x86_64 Cross Compile Toolchain
cc_toolchain(
    name = "jp512_aarch64_gcc-11_linux_x86_64",
    all_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp512_all_files",
    ar_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:ar_files",
    compiler_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp512_compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp512_linker_files",
    objcopy_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp512_config",
    toolchain_identifier = "ubuntu-22.04-arm64-cross",
)

# Generic ARM64 cross-compile on X86-64 host toolchain:
toolchain(
    name = "linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    toolchain = ":cc_toolchain_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# gcc11 cross compile on x86_64 host targeting ARM64 Ubuntu 22.04 / Linux 5.10.0
# NOT DONE
toolchain(
    name = "jp512_linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        "//platforms:tegra",
        "//platforms:jetpack_512",
    ],
    toolchain = ":jp512_aarch64_gcc-11_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# gcc11 cross compile on x86_64 host targeting ARM64 Ubuntu 22.04 / Linux 5.15.0
toolchain(
    name = "jp62_linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        "//platforms:tegra",
        "//platforms:jetpack_62",
    ],
    toolchain = ":jp62_aarch64_gcc-11_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# The JP62 toolchain with fewer platform constraints, which is just the
# Ubuntu 22.04 gcc-11 arm64 cross-compile toolchain:
toolchain(
    name = "aarch64_linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    toolchain = ":jp62_aarch64_gcc-11_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
