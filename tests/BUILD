load("@rules_cc//cc:defs.bzl", "cc_binary")

package(default_visibility = ["//visibility:public"])

cc_binary(
    name = "hello_c",
    srcs = ["hello.c"],
)

cc_binary(
    name = "hello_cc",
    srcs = ["hello.cc"],
)

# cc_binary's implicit .stripped output is the only thing that runs the toolchain's
# strip, and nothing else in this package depends on it -- so without this filegroup
# //:all never creates a CcStrip action and the hermetic-sandbox guard never sees
# whether the strip wrapper's libraries are declared and reachable.
filegroup(
    name = "stripped",
    srcs = [
        "hello_c.stripped",
        "hello_cc.stripped",
    ],
)
