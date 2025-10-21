"""deps.bzl"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Using ARM release https://developer.arm.com/downloads/-/gnu-rm (Version 10.3-2021.10)

def aarch64_linux_gnu_deps():
    """Workspace dependencies for the aarch64 linux gnu toolchain"""

    http_archive(
        name = "ubuntu-22.04-arm64-cross",
        build_file = "@aarch64_linux_gnu//toolchain:ubuntu-22.04-arm64-cross.BUILD",
        sha256 = "655de222f8a0917ca0f88a0160e93736ae69dcf1f018d68b856c8ae6713f71c4",
        strip_prefix = "ubuntu-22.04-arm64-cross",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/ubuntu-22.04-arm64-cross.tar.zst",
        ],
    )

    http_archive(
        name = "ubuntu-22.04-aarch64-native",
        build_file = "@aarch64_linux_gnu//toolchain:ubuntu-22.04-native.BUILD",
        sha256 = "4f9a7a99c083d288b00f1120551853155e163196b3474095b3b2c31544f2d69a",
        strip_prefix = "ubuntu-22.04-aarch64-native",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/ubuntu-22.04-aarch64-native.tar.zst",
        ],
    )

    http_archive(
        name = "ubuntu-22.04-x86_64-native",
        build_file = "@aarch64_linux_gnu//toolchain:ubuntu-22.04-native.BUILD",
        sha256 = "8d3cfe7ee15ceb690ac9e88be66d419d0dbbb84094767cab34257b8ca8923867",
        strip_prefix = "ubuntu-22.04-x86_64-native",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/ubuntu-22.04-x86_64-native.tar.zst",
        ],
    )

    # For Jetpack 6.2 cross compile:
    http_archive(
        name = "linux-libc-5.15.0-aarch64-cross",
	build_file = "@aarch64_linux_gnu//toolchain:linux-libc.BUILD",
        sha256 = "7fcb6058b1bcb77dff0cce03872d774830b0e82fd219659d488a6c7978e77b23",
        strip_prefix = "linux-libc-dev-arm64-cross",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev-arm64-cross_5.15.0-22.22cross3.tar.zst",
        ],
    )

    # For Jetpack 5.1.2 cross compile:
    http_archive(
        name = "linux-libc-5.4.0-aarch64-cross",
	build_file = "@aarch64_linux_gnu//toolchain:linux-libc.BUILD",
        sha256 = "8deb000e7cb26ac0d39e3092d52e18d901ce9cea1c8026158993535dfdb2187a",
        strip_prefix = "linux-libc-dev-arm64-cross",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev-arm64-cross_5.4.0-110.124cross1.tar.zst",
        ],
    )

    # For x86_64 host builds:
    http_archive(
	name = "linux-libc-5.15.0-x86_64",
	build_file = "@aarch64_linux_gnu//toolchain:linux-libc.BUILD",
	sha256 = "923a926a73f0c182e512a6fdacfae249120d8994be53ed8300405106069c6323",
	strip_prefix = "linux-libc-dev",
	urls = [
	    "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev_5.15.0-157.167-x86_64.tar.zst",
	],
    )

    # For aarch64 host and native jp62 builds:
    http_archive(
	name = "linux-libc-5.15.0-aarch64",
	build_file = "@aarch64_linux_gnu//toolchain:linux-libc.BUILD",
	sha256 = "30280d8d2d384b724812f6846d2238201d5fc61c9214ab1934c61fccde637f73",
	strip_prefix = "linux-libc-dev",
	urls = [
	    "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev_5.15.0-157.167-aarch64.tar.zst",
	],
    )

    # For native jp512 builds:
    http_archive(
        name = "linux-libc-5.4.0-aarch64",
        build_file = "@aarch64_linux_gnu//toolchain:linux-libc.BUILD",
        sha256 = "446f8b31cc67900efdff29b09f7eb70076ab5e41edcd6d8f8fdb9129cb3a771e",
        strip_prefix = "linux-libc-dev",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev_5.4.0-216.236-aarch64.tar.zst",
        ],
    )

    # Register the Jatpack toolchains first, so bazel chooses them over the generic toolchains:
    native.register_toolchains(
        "@aarch64_linux_gnu//toolchain:jp512_linux_x86_64",
        "@aarch64_linux_gnu//toolchain:jp62_linux_x86_64",
        "@aarch64_linux_gnu//toolchain:jp512_linux_aarch64",
    )

    native.register_toolchains(
        "@aarch64_linux_gnu//toolchain:aarch64_linux_x86_64",
        "@aarch64_linux_gnu//toolchain:native_linux_aarch64",
        "@aarch64_linux_gnu//toolchain:native_linux_x86_64",
    )
