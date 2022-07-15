# BUILD

package(default_visibility = ["//visibility:public"])

config_setting(
    name = "linux",
    values = {"host_cpu": "k8"},
)

filegroup(
    name = "gcc",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-gcc"],
    }),
)

filegroup(
    name = "ar",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-ar"],
    }),
)

filegroup(
    name = "ld",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-ld"],
    }),
)

filegroup(
    name = "nm",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-nm"],
    }),
)

filegroup(
    name = "objcopy",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-objcopy"],
    }),
)

filegroup(
    name = "objdump",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-objdump"],
    }),
)

filegroup(
    name = "strip",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-strip"],
    }),
)

filegroup(
    name = "as",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-as"],
    }),
)

filegroup(
    name = "gdb",
    srcs = select({
        "linux": ["@aarch64_linux_gnu_linux_x86_64//:bin/aarch64-none-linux-gnu-gdb"],
    }),
)
