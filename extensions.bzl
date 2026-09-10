"""Module extension declaring the archives the cc_toolchains are built from.

Bazel 9 dropped WORKSPACE support, so the toolchain is wired up through bzlmod
only: consumers pull in the archives with

    toolchains = use_extension("@aarch64_linux_gnu//:extensions.bzl", "toolchains")
    use_repo(toolchains, ...)

which MODULE.bazel does for this repo itself.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//toolchain:archive_repo.bzl", "cc_archive_repo")

_ARM64_CROSS_BUILD_EXTRA = """
filegroup(
    name = "jp62_all_files",
    srcs = [
        ":ar_files",
        ":jp62_compiler_files",
        ":jp62_linker_files",
        ":strip_files",
    ],
)

filegroup(
    name = "jp62_compiler_files",
    srcs = [
        ":compiler_files",
        ":jp62_compiler_pieces",
    ],
)

filegroup(
    name = "jp62_linker_files",
    srcs = [
        ":jp62_compiler_pieces",
        ":linker_files",
    ],
)

filegroup(
    name = "jp62_compiler_pieces",
    srcs = [
        "@linux-libc-5.15.0-aarch64-cross//:headers",
        ":compiler_pieces",
    ],
)

filegroup(
    name = "jp512_all_files",
    srcs = [
        ":ar_files",
        ":jp512_compiler_files",
        ":jp512_linker_files",
        ":strip_files",
    ],
)

filegroup(
    name = "jp512_compiler_files",
    srcs = [
        ":compiler_files",
        ":jp512_compiler_pieces",
    ],
)

filegroup(
    name = "jp512_linker_files",
    srcs = [
        ":jp512_compiler_pieces",
        ":linker_files",
    ],
)

filegroup(
    name = "jp512_compiler_pieces",
    srcs = [
        "@linux-libc-5.4.0-aarch64-cross//:headers",
        ":compiler_pieces",
    ],
)

cc_linux_gnu_config(
    name = "jp62_config",
    gcc_repo = "ubuntu-22.04-arm64-cross",
    gcc_version = "11",
    host_system_name = "linux_x86_64",
    sysroot = ":gcc",
    include_paths = [
        "usr/lib/gcc-cross/aarch64-linux-gnu/11/include/",
        "usr/aarch64-linux-gnu/include/c++/11/",
        "usr/aarch64-linux-gnu/include/c++/11/aarch64-linux-gnu",
        "usr/aarch64-linux-gnu/include/",
    ],
    libc_headers = "@linux-libc-5.15.0-aarch64-cross//:headers",
    libc_include_paths = ["usr/aarch64-linux-gnu/include/"],
    toolchain_identifier = "ubuntu-22.04-arm64-cross",
    wrapper_path = "wrappers/aarch64-linux-gnu-",
)

cc_linux_gnu_config(
    name = "jp512_config",
    gcc_repo = "ubuntu-22.04-arm64-cross",
    gcc_version = "11",
    host_system_name = "linux_x86_64",
    sysroot = ":gcc",
    include_paths = [
        "usr/lib/gcc-cross/aarch64-linux-gnu/11/include/",
        "usr/aarch64-linux-gnu/include/c++/11/",
        "usr/aarch64-linux-gnu/include/c++/11/aarch64-linux-gnu",
        "usr/aarch64-linux-gnu/include/",
    ],
    libc_headers = "@linux-libc-5.4.0-aarch64-cross//:headers",
    libc_include_paths = ["usr/aarch64-linux-gnu/include/"],
    toolchain_identifier = "ubuntu-22.04-arm64-cross",
    wrapper_path = "wrappers/aarch64-linux-gnu-",
)

# Ubuntu 22.04 gcc 11 ARM64 on x86_64 Cross Compile Toolchain
cc_toolchain(
    name = "aarch64_gcc-11_linux_x86_64",
    all_files = ":jp62_all_files",
    ar_files = ":ar_files",
    compiler_files = ":jp62_compiler_files",
    dwp_files = ":empty",
    linker_files = ":jp62_linker_files",
    objcopy_files = ":objcopy_files",
    strip_files = ":strip_files",
    supports_param_files = 0,
    toolchain_config = ":jp62_config",
    toolchain_identifier = "jp62_linux_x86_64",
)

# Same definitions as aarch64_gcc-11_linux_x86_64, but creates a distinct target,
# to make the output of bazel --toolchain_resolution_debug clearer:
cc_toolchain(
    name = "jp62_aarch64_gcc-11_linux_x86_64",
    all_files = ":jp62_all_files",
    ar_files = ":ar_files",
    compiler_files = ":jp62_compiler_files",
    dwp_files = ":empty",
    linker_files = ":jp62_linker_files",
    objcopy_files = ":objcopy_files",
    strip_files = ":strip_files",
    supports_param_files = 0,
    toolchain_config = ":jp62_config",
    toolchain_identifier = "jp62_linux_x86_64",
)

# Same as jp62, but bundles linux-libc-headers from kernel 5.4.0:
cc_toolchain(
    name = "jp512_aarch64_gcc-11_linux_x86_64",
    all_files = ":jp512_all_files",
    ar_files = ":ar_files",
    compiler_files = ":jp512_compiler_files",
    dwp_files = ":empty",
    linker_files = ":jp512_linker_files",
    objcopy_files = ":objcopy_files",
    strip_files = ":strip_files",
    supports_param_files = 0,
    toolchain_config = ":jp512_config",
    toolchain_identifier = "jp512_linux_x86_64",
)
"""

_AARCH64_NATIVE_BUILD_EXTRA = """
filegroup(
    name = "aarch64_compiler_pieces",
    srcs = [
        "@linux-libc-5.15.0-aarch64//:headers",
        ":compiler_pieces",
    ],
)

filegroup(
    name = "aarch64_all_files",
    srcs = [
        ":ar_files",
        ":aarch64_compiler_files",
        ":aarch64_linker_files",
        ":strip_files",
    ],
)

filegroup(
    name = "aarch64_compiler_files",
    srcs = [
        ":aarch64_compiler_pieces",
        ":compiler_files",
    ],
)

filegroup(
    name = "aarch64_linker_files",
    srcs = [
        ":aarch64_compiler_pieces",
        ":linker_files",
    ],
)

# Set of files with Jetpack 5.1.2 linux-libc headers:
filegroup(
    name = "jp512_compiler_pieces",
    srcs = [
        "@linux-libc-5.4.0-aarch64//:headers",
        ":compiler_pieces",
    ],
)

filegroup(
    name = "jp512_all_files",
    srcs = [
        ":ar_files",
        ":jp512_compiler_files",
        ":jp512_linker_files",
        ":strip_files",
    ],
)

filegroup(
    name = "jp512_compiler_files",
    srcs = [
        ":compiler_files",
        ":jp512_compiler_pieces",
    ],
)

filegroup(
    name = "jp512_linker_files",
    srcs = [
        ":jp512_compiler_pieces",
        ":linker_files",
    ],
)

cc_linux_gnu_config(
    name = "aarch64_config",
    gcc_repo = "ubuntu-22.04-aarch64-native",
    gcc_version = "11",
    host_system_name = "linux_aarch64",
    sysroot = ":gcc",
    include_paths = [
        # Path order is important to avoid bazel errors about undeclared files:
        "usr/lib/gcc/aarch64-linux-gnu/11/include/",
        "usr/include/aarch64-linux-gnu/",
        "usr/include/c++/11/",
        "usr/include/aarch64-linux-gnu/c++/11/",
        "usr/include/",
    ],
    libc_headers = "@linux-libc-5.15.0-aarch64//:headers",
    libc_include_paths = [
        "usr/include/",
        "usr/include/aarch64-linux-gnu/",
    ],
    toolchain_identifier = "ubuntu-22.04-aarch64-native",
    wrapper_path = "wrappers/aarch64-linux-gnu-",
)

cc_linux_gnu_config(
    name = "jp512_config",
    gcc_repo = "ubuntu-22.04-aarch64-native",
    gcc_version = "11",
    host_system_name = "linux_aarch64",
    sysroot = ":gcc",
    include_paths = [
        # Path order is important to avoid bazel errors about undeclared files:
        "usr/lib/gcc/aarch64-linux-gnu/11/include/",
        "usr/include/aarch64-linux-gnu/",
        "usr/include/c++/11/",
        "usr/include/aarch64-linux-gnu/c++/11/",
        "usr/include/",
    ],
    libc_headers = "@linux-libc-5.4.0-aarch64//:headers",
    libc_include_paths = [
        "usr/include/",
        "usr/include/aarch64-linux-gnu/",
    ],
    toolchain_identifier = "ubuntu-22.04-aarch64-native",
    wrapper_path = "wrappers/aarch64-linux-gnu-",
)

# Ubuntu 22.04 gcc 11 aarch64 Native Toolchain
cc_toolchain(
    name = "gcc-11_linux_aarch64",
    all_files = ":aarch64_all_files",
    ar_files = ":ar_files",
    compiler_files = ":aarch64_compiler_files",
    dwp_files = ":empty",
    linker_files = ":aarch64_linker_files",
    objcopy_files = ":objcopy_files",
    strip_files = ":strip_files",
    supports_param_files = 0,
    toolchain_config = ":aarch64_config",
    toolchain_identifier = "linux_aarch64",
)

# Ubuntu 22.04 gcc 11 aarch64 jp512 toolchain
cc_toolchain(
    name = "jp512_aarch64_gcc-11_linux",
    all_files = ":jp512_all_files",
    ar_files = ":ar_files",
    compiler_files = ":jp512_compiler_files",
    dwp_files = ":empty",
    linker_files = ":jp512_linker_files",
    objcopy_files = ":objcopy_files",
    strip_files = ":strip_files",
    supports_param_files = 0,
    toolchain_config = ":jp512_config",
    toolchain_identifier = "linux_aarch64",
)
"""

_X86_64_NATIVE_BUILD_EXTRA = """
filegroup(
    name = "x86_64_compiler_pieces",
    srcs = [
        "@linux-libc-5.15.0-x86_64//:headers",
        ":compiler_pieces",
    ],
)

filegroup(
    name = "x86_64_all_files",
    srcs = [
        ":ar_files",
        ":strip_files",
        ":x86_64_compiler_files",
        ":x86_64_linker_files",
    ],
)

filegroup(
    name = "x86_64_compiler_files",
    srcs = [
        ":compiler_files",
        ":x86_64_compiler_pieces",
    ],
)

filegroup(
    name = "x86_64_linker_files",
    srcs = [
        ":linker_files",
        ":x86_64_compiler_pieces",
    ],
)

cc_linux_gnu_config(
    name = "x86_64_config",
    gcc_repo = "ubuntu-22.04-x86_64-native",
    gcc_version = "11",
    host_system_name = "linux_x86_64",
    sysroot = ":gcc",
    include_paths = [
        "usr/lib/gcc/x86_64-linux-gnu/11/include/",
        "usr/include/x86_64-linux-gnu/",
        "usr/include/c++/11/",
        "usr/include/x86_64-linux-gnu/c++/11/",
        "usr/include/",
    ],
    libc_headers = "@linux-libc-5.15.0-x86_64//:headers",
    libc_include_paths = [
        "usr/include/",
        "usr/include/x86_64-linux-gnu/",
    ],
    target_cpu = "k8",
    target_system_name = "linux_x86_64",
    toolchain_identifier = "ubuntu-22.04-x86_64-native",
    wrapper_path = "wrappers/x86_64-linux-gnu-",
)

# Ubuntu 22.04 gcc 11 x86_64 Native Toolchain
cc_toolchain(
    name = "gcc-11_linux_x86_64",
    all_files = ":x86_64_all_files",
    ar_files = ":ar_files",
    compiler_files = ":x86_64_compiler_files",
    dwp_files = ":empty",
    linker_files = ":x86_64_linker_files",
    objcopy_files = ":objcopy_files",
    strip_files = ":strip_files",
    supports_param_files = 0,
    toolchain_config = ":x86_64_config",
    toolchain_identifier = "linux_x86_64",
)
"""

def _toolchain_repositories():
    cc_archive_repo(
        name = "ubuntu-22.04-arm64-cross-toolchain",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/ubuntu-22.04-arm64-cross-2.tar.zst",
        ],
        sha256 = "14d7e4f9cc87a3320033062a6978d848e5702186c9478b73cfb1c03744302b5b",
        strip_prefix = "ubuntu-22.04-arm64-cross",
        raw_build_file = Label("//toolchain:ubuntu-22.04-arm64-cross.BUILD"),
        variant = "cross",
        prefix = "aarch64-linux-gnu",
        gcc_version = "11",
        build_extra = _ARM64_CROSS_BUILD_EXTRA,
    )

    cc_archive_repo(
        name = "ubuntu-22.04-aarch64-native-toolchain",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/ubuntu-22.04-aarch64-native-2.tar.zst",
        ],
        sha256 = "2b009b59377e21581d67b0f5d6f314a0ef2249b1941b4fca03685bfc3facf8de",
        strip_prefix = "ubuntu-22.04-aarch64-native",
        raw_build_file = Label("//toolchain:ubuntu-22.04-native.BUILD"),
        variant = "native",
        prefix = "aarch64-linux-gnu",
        gcc_version = "11",
        build_extra = _AARCH64_NATIVE_BUILD_EXTRA,
    )

    cc_archive_repo(
        name = "ubuntu-22.04-x86_64-native-toolchain",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/ubuntu-22.04-x86_64-native-2.tar.zst",
        ],
        sha256 = "342fc43d0fa977edcb4e9d6840a0c289bc09123327eff05c6a399964a0bfaaa2",
        strip_prefix = "ubuntu-22.04-x86_64-native",
        raw_build_file = Label("//toolchain:ubuntu-22.04-native.BUILD"),
        variant = "native",
        prefix = "x86_64-linux-gnu",
        gcc_version = "11",
        build_extra = _X86_64_NATIVE_BUILD_EXTRA,
    )

    # For Jetpack 6.2 cross compile:
    http_archive(
        name = "linux-libc-5.15.0-aarch64-cross",
        build_file = Label("//toolchain:linux-libc.BUILD"),
        sha256 = "7fcb6058b1bcb77dff0cce03872d774830b0e82fd219659d488a6c7978e77b23",
        strip_prefix = "linux-libc-dev-arm64-cross",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev-arm64-cross_5.15.0-22.22cross3.tar.zst",
        ],
    )

    # For Jetpack 5.1.2 cross compile:
    http_archive(
        name = "linux-libc-5.4.0-aarch64-cross",
        build_file = Label("//toolchain:linux-libc.BUILD"),
        sha256 = "8deb000e7cb26ac0d39e3092d52e18d901ce9cea1c8026158993535dfdb2187a",
        strip_prefix = "linux-libc-dev-arm64-cross",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev-arm64-cross_5.4.0-110.124cross1.tar.zst",
        ],
    )

    # For x86_64 host builds:
    http_archive(
        name = "linux-libc-5.15.0-x86_64",
        build_file = Label("//toolchain:linux-libc.BUILD"),
        sha256 = "923a926a73f0c182e512a6fdacfae249120d8994be53ed8300405106069c6323",
        strip_prefix = "linux-libc-dev",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev_5.15.0-157.167-x86_64.tar.zst",
        ],
    )

    # For aarch64 host and native jp62 builds:
    http_archive(
        name = "linux-libc-5.15.0-aarch64",
        build_file = Label("//toolchain:linux-libc.BUILD"),
        sha256 = "30280d8d2d384b724812f6846d2238201d5fc61c9214ab1934c61fccde637f73",
        strip_prefix = "linux-libc-dev",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev_5.15.0-157.167-aarch64.tar.zst",
        ],
    )

    # For native jp512 builds:
    http_archive(
        name = "linux-libc-5.4.0-aarch64",
        build_file = Label("//toolchain:linux-libc.BUILD"),
        sha256 = "446f8b31cc67900efdff29b09f7eb70076ab5e41edcd6d8f8fdb9129cb3a771e",
        strip_prefix = "linux-libc-dev",
        urls = [
            "http://dependency-mirror.s3.amazonaws.com/toolchain/linux-libc-dev_5.4.0-216.236-aarch64.tar.zst",
        ],
    )

def _toolchains_impl(_module_ctx):
    _toolchain_repositories()

toolchains = module_extension(
    implementation = _toolchains_impl,
    doc = "Fetches the gcc and linux-libc archives the cc_toolchains are built from.",
)
