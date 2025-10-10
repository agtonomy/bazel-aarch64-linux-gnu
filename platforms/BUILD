# Define all of the platform constraints here because bazel will only
# automatically resolve a toolchain if all contraints for the target platform
# match, including our contraints for jetpack and nvidia

# Define all of the platform constraints here because bazel will only
# automatically resolve a toolchain if all contraints for the target platform
# match, including our custom contraints for jetpack and nvidia

package(default_visibility = ["//visibility:public"])

constraint_setting(name = "jetpack_version")

constraint_setting(name = "nvidia_platform")

constraint_value(
    name = "jetpack_512",
    constraint_setting = ":jetpack_version",
    visibility = ["//visibility:public"],
)

constraint_value(
    name = "jetpack_62",
    constraint_setting = ":jetpack_version",
    visibility = ["//visibility:public"],
)

constraint_value(
    name = "tegra",
    constraint_setting = ":nvidia_platform",
    visibility = ["//visibility:public"],
)

platform(
    name = "tegra_jetpack_512",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:arm64",
        ":jetpack_512",
        ":tegra",
    ],
    visibility = ["//visibility:public"],
)

platform(
    name = "tegra_jetpack_62",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:arm64",
        ":jetpack_62",
        ":tegra",
    ],
    visibility = ["//visibility:public"],
)
