# bazel-aarch64-linux-gnu
This repo provides a Bazel cross toolchain for x86_64/Linux host and aarch64/Linux target

The structure was inspired by: https://asnaghi.me/post/embedded-bazel/

## Toolchain
The toolchain implemented is : `gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu`

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
build:aarch64 --incompatible_enable_cc_toolchain_resolution --platforms=@aarch64_linux_gnu//platforms:aarch64_linux_generic
```

Or the older method
```bash
build:aarch64 --cpu=aarch64 --crosstool_top=@aarch64_linux_gnu//toolchain --host_crosstool_top=@bazel_tools//tools/cpp:toolchain
```

Finally, build a cc_binary target like so:
```bash
bazel build --config=aarch64 //path/to/target
```
