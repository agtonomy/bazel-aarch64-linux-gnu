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
    srcs = glob([
        "usr/aarch64-linux-gnu/include/**",
        "usr/include/**",
    ]),
)
