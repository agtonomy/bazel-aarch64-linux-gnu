"""deps.bzl"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Using Linaro release https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/

def aarch64_linux_gnu_deps():
    """Workspace dependencies for the aarch64 linux gnu toolchain"""

    http_archive(
        name = "aarch64_linux_gnu_linux_x86_64",
        build_file = "@arm_none_eabi//toolchain:compiler.BUILD",
        sha256 = "3b6465fb91564b54bbdf9578b4cc3aa198dd363f7a43820eab06ea2932c8e0bf",
        strip_prefix = "gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu",
        url = "https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz",
    )

    native.register_toolchains(
        "@arm_none_eabi//toolchain:linux_x86_64",
    )
