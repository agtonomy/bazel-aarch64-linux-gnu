# toolchains/BUILD.bazel

# gcc11 cross compile on x86_64 host targeting ARM64 Ubuntu 22.04 / Linux 5.10.0
#
# The cc_toolchain and cc_toolchain_config for this live in the generated
# @ubuntu-22.04-arm64-cross repo, which also fetches the compiler archive and holds its
# wrapper scripts: a cc_toolchain's tool_path strings resolve relative to the package of
# the cc_toolchain target, with no way to reach into a different repository, so all
# three have to live together. See toolchain/archive_repo.bzl.
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
    toolchain = "@ubuntu-22.04-arm64-cross//:jp512_aarch64_gcc-11_linux_x86_64",
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
    toolchain = "@ubuntu-22.04-arm64-cross//:jp62_aarch64_gcc-11_linux_x86_64",
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
   ],
    toolchain = "@ubuntu-22.04-arm64-cross//:aarch64_gcc-11_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Ubuntu 22.04 gcc 11 aarch64 Native Toolchain
#
# The cc_toolchain and cc_toolchain_config for this live in the generated
# @ubuntu-22.04-aarch64-native repo; see toolchain/archive_repo.bzl.
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
    toolchain = "@ubuntu-22.04-aarch64-native//:gcc-11_linux_aarch64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Ubuntu 22.04 gcc 11 x86_64 Native Toolchain
#
# The cc_toolchain and cc_toolchain_config for this live in the generated
# @ubuntu-22.04-x86_64-native repo; see toolchain/archive_repo.bzl.
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
    toolchain = "@ubuntu-22.04-x86_64-native//:gcc-11_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "jp512_linux_aarch64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        "//platforms:tegra",
        "//platforms:jetpack_512",
   ],
    toolchain = "@ubuntu-22.04-aarch64-native//:jp512_aarch64_gcc-11_linux",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
