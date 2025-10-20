# bazel-aarch64-linux-gnu
This repo provides a Bazel cross toolchain for x86_64/Linux host and aarch64/Linux target

The structure was inspired by: https://asnaghi.me/post/embedded-bazel/,
then re-worked to support bazel CC toolchain auto-resolution / platforms.

## Toolchain
The toolchain implemented is: gcc-11-aarch64-linux-gnu_11.4.0, from Ubuntu 22.04

The toolchain is split into two packages, one with almost everything needed to compile,
the other with linux-libc headers, which need to match the target platform's kernel.

The main package contains (tarred from / in their original install paths):
 - gcc
 - g++
 - cpp
 - libgcc-s1
 - libgcc-dev
 - libstdc++
 - libstdc++-dev
 - libc
 - libc-dev
 - binutils

## Usage
Include the following in your `WORKSPACE` with appropriate commit and sha256sum

```python

AARCH64_LINUX_GNU_COMMIT = "INSERT COMMIT HASH HERE"

http_archive(
    name = "aarch64_linux_gnu",
    sha256 = "INSERT SHA256 HERE",
    strip_prefix = "bazel-aarch64-linux-gnu-" + AARCH64_LINUX_GNU_COMMIT,
    urls = ["https://github.com/agtonomy/bazel-aarch64-linux-gnu/archive/" + AARCH64_LINUX_GNU_COMMIT + ".tar.gz"],
)

load("@aarch64_linux_gnu//:deps.bzl", "aarch64_linux_gnu_deps")

aarch64_linux_gnu_deps()
```

Then include the following in your `.bazelrc`
```bash
build --incompatible_enable_cc_toolchain_resolution
build:jetpack_512 --platforms=@aarch64_linux_gnu//platforms:jetpack_512
build:jetpack_62 --platforms=@aarch64_linux_gnu//platforms:jetpack_62
```

A side effect of toolchain resolution is that the bazel output paths don't include the target cpu,
to achieve something similar add:

```bash
build --experimental_platform_in_output_dir
```

Finally, build a cc_binary target like so:
```bash
bazel build --config jetpack62 //path/to/target
```

## How does this all work?
Beginning from the project repository, the toolchain resolution process goes like:
1. `aarch64_linux_gnu_deps` is loaded from `deps.bzl` and invoked.
2. `aarch64_linux_gnu_deps` calls `native.register_toolchains` with labels of toolchains,
    which are defined in `toolchain/BUILD`. Bazel prefers toolchains registered first if
    multiple toolchains support a target platform.
3. `toolchain/BUILD` calls `toolchain` on outputs from `cc_toolchain` to associate them
    with platforms via host and target constraints. Note that constraints which are set
    on build target platform which are not assigned to a given toolchain are not considered,
    thus the order mentioned above is used to give jetpack toolchains (with more specific
    platform constraints) higher selection priority over the generic toolchains.
4. The `cc_toolchain` calls collect a set of toolchain files (executables, shared libraries,
    and headers,) plus a config, both types are defined in a BUILD path specific to each
    compiler, eg `toolchain/ubuntu-22.04-arm64-cross/linux_x86_64/BUILD`. Each compiler may
    support multiple similar platforms by including slightly different headers and calling
    `cc_toolchain` with platform-specific filegroups and config.
5. The config is created by calling the `cc_linux_gnu_config`, loaded from `toolchain/config.bzl`,
    which is a wrapper around `cc_common.create_cc_toolchain_config_info`. This is where the
    various toolchain executables (really shell scripts which wrap them,) and build flags are
    defined. Keep in mind that relative paths are relative to the execroot which bazel sets
    up for each step of the build, with files from packages in a subdirectory of `external`,
    eg `<execroot>/external/ubuntu-22.04-x86_64-native/usr/bin/x86_64-linux-gnu-ld`, which
    breaks down to `external`, then the package name from the `http_archive` call, then the
    path from within the tar archive (after the strip prefix is applied.)
