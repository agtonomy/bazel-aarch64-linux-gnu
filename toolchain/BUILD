# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain", "cc_toolchain_suite")

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8": ":cc_toolchain_linux_x86_64",
    },
)

cc_toolchain(
    name = "cc_toolchain_linux_x86_64",
    all_files = "//toolchain/aarch64-linux-gnu/linux_x86_64:all_files",
    ar_files = "//toolchain/aarch64-linux-gnu/linux_x86_64:ar_files",
    compiler_files = "//toolchain/aarch64-linux-gnu/linux_x86_64:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/aarch64-linux-gnu/linux_x86_64:linker_files",
    objcopy_files = "//toolchain/aarch64-linux-gnu/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/aarch64-linux-gnu/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/aarch64-linux-gnu/linux_x86_64:config",
    toolchain_identifier = "aarch64_linux_gnu_linux_x86_64",
)

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
