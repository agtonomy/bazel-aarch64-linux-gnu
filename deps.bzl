"""deps.bzl"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Using Linaro release https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/

def aarch64_linux_gnu_deps():
    """Workspace dependencies for the aarch64 linux gnu toolchain"""

    http_archive(
        name = "aarch64-none-linux-gnu",
        build_file = "@aarch64_linux_gnu//toolchain:compiler.BUILD",
        sha256 = "52dbac3eb71dbe0916f60a8c5ab9b7dc9b66b3ce513047baa09fae56234e53f3",
        strip_prefix = "gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu",
        url = "https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz",
    )

    native.register_toolchains(
        "@aarch64_linux_gnu//toolchain:linux_x86_64",
    )
