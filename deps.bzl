"""deps.bzl"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Using ARM release https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads/9-2-2019-12

def aarch64_linux_gnu_deps():
    """Workspace dependencies for the aarch64 linux gnu toolchain"""

    http_archive(
        name = "aarch64_linux_gnu_linux_x86_64",
        build_file = "@aarch64_linux_gnu//toolchain:compiler.BUILD",
        sha256 = "8dfe681531f0bd04fb9c53cf3c0a3368c616aa85d48938eebe2b516376e06a66",
        strip_prefix = "gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu",
        url = "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz",
    )

    native.register_toolchains(
        "@aarch64_linux_gnu//toolchain:linux_x86_64",
    )
