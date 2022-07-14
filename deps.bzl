"""deps.bzl"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Using ARM release https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads/9-2-2019-12

def aarch64_linux_gnu_deps():
    """Workspace dependencies for the aarch64 linux gnu toolchain"""

    http_archive(
        name = "aarch64_linux_gnu_linux_x86_64",
        build_file = "@aarch64_linux_gnu//toolchain:compiler.BUILD",
        sha256 = "1e33d53dea59c8de823bbdfe0798280bdcd138636c7060da9d77a97ded095a84",
        strip_prefix = "gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu",
        url = "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.xz",
    )

    native.register_toolchains(
        "@aarch64_linux_gnu//toolchain:linux_x86_64",
    )
