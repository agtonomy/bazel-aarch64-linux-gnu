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
build:jetpack_512 --incompatible_enable_cc_toolchain_resolution --platforms=@aarch64_linux_gnu//platforms:jetpack_512
```

A side effect of toolchain resolution is that the bazel output paths don't include the target cpu,
to achieve something similar add:

```bash
build --experimental_platform_in_output_dir
```

Finally, build a cc_binary target like so:
```bash
bazel build --config=aarch64 //path/to/target
```

## How does this all work?
Fill this out soon.
