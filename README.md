# bazel-aarch64-linux-gnu
Bazel cross toolchains targetting aarch64/linux systems

The structure was inspired by: https://asnaghi.me/post/embedded-bazel/

## Toolchains
Currently there is one toolchain implemented: `gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu`

It is intended for x86_64/linux hosts. There will likely be more toolchains added in the future.

## Usage
Include the following in your `WORKSPACE`
```python
http_archive(
    name = "aarch64_linux_gnu",
    sha256 = "INSERT SHA256 of .tar.gz",
    strip_prefix = "Catch2-2.13.7",
    urls = ["https://github.com/agtonomy/bazel-aarch64-linux-gnu/archive/COMMIT_HASH.tar.gz"],
)

load("@aarch64_linux_gnu//:deps.bzl", "aarch64_linux_gnu_deps")
aarch64_linux_gnu_deps()
```

Then include the following in your `.bazelrc`
```
build:aarch64 --incompatible_enable_cc_toolchain_resolution --platforms=@aarch64_linux_gnu//platforms:aarch64_linux_generic
```

Finally, build a cc_binary target like so:
```bash
bazel build --config=aarch64 //path/to/target
```
