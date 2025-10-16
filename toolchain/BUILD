# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain")

# Ubuntu 22.04 gcc 11 ARM64 on x86_64 Cross Compile Toolchain
cc_toolchain(
    name = "aarch64_gcc-11_linux_x86_64",
    all_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_all_files",
    ar_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:ar_files",
    compiler_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_linker_files",
    objcopy_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/ubuntu-22.04-arm64-cross/linux_x86_64:jp62_config",
    toolchain_identifier = "jp62_linux_x86_64",
)

# Same definitions as aarch64_gcc-11_linux_x86_64, but creates a distinct target
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
    toolchain_identifier = "jp62_linux_x86_64",
)

# Same as jp62, but bundles linux-libc-headers from kernel 5.4.0:
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
    toolchain_identifier = "jp512_linux_x86_64",
)

# gcc11 cross compile on x86_64 host targeting ARM64 Ubuntu 22.04 / Linux 5.10.0
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

toolchain(
    name = "aarch64_linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        "//platforms:generic",
   ],
    toolchain = ":aarch64_gcc-11_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Ubuntu 22.04 gcc 11 aarch64 Native Toolchain
cc_toolchain(
    name = "gcc-11_linux_aarch64",
    all_files = "//toolchain/ubuntu-22.04-native/linux_aarch64:aarch64_all_files",
    ar_files = "//toolchain/ubuntu-22.04-native/linux_aarch64:ar_files",
    compiler_files = "//toolchain/ubuntu-22.04-native/linux_aarch64:aarch64_compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/ubuntu-22.04-native/linux_aarch64:aarch64_linker_files",
    objcopy_files = "//toolchain/ubuntu-22.04-native/linux_aarch64:objcopy_files",
    strip_files = "//toolchain/ubuntu-22.04-native/linux_aarch64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/ubuntu-22.04-native/linux_aarch64:aarch64_config",
    toolchain_identifier = "linux_aarch64",
)

toolchain(
    name = "native_linux_aarch64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
   ],
    toolchain = ":gcc-11_linux_aarch64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Ubuntu 22.04 gcc 11 x86_64 Native Toolchain
cc_toolchain(
    name = "gcc-11_linux_x86_64",
    all_files = "//toolchain/ubuntu-22.04-native/linux_x86_64:x86_64_all_files",
    ar_files = "//toolchain/ubuntu-22.04-native/linux_x86_64:ar_files",
    compiler_files = "//toolchain/ubuntu-22.04-native/linux_x86_64:x86_64_compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/ubuntu-22.04-native/linux_x86_64:x86_64_linker_files",
    objcopy_files = "//toolchain/ubuntu-22.04-native/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/ubuntu-22.04-native/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/ubuntu-22.04-native/linux_x86_64:x86_64_config",
    toolchain_identifier = "linux_x86_64",
)

toolchain(
    name = "native_linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
   ],
    toolchain = ":gcc-11_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
