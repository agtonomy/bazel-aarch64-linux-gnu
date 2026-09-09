package(default_visibility = ["//visibility:public"])

# Path examples:
# Cross Compiler:
# usr/aarch64-linux-gnu/include/linux/v4l2-controls.h
# Native aarch64 Compiler:
# usr/include/linux/v4l2-controls.h
# Native x86_64 Compiler:
# usr/include/linux/v4l2-controls.h

filegroup(
    name = "headers",
    srcs = glob(
        [
            "usr/aarch64-linux-gnu/include/**",
            "usr/include/**",
        ],
        # Each downstream archive (native aarch64, native x86_64, cross) only ships one
        # of these two include layouts; the other pattern legitimately matches nothing.
        allow_empty = True,
    ),
)
