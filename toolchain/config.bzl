load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path", "with_feature_set")

def wrapper_path(ctx, tool):
    wrapped_path = "{}/aarch64-none-linux-gnu-{}{}".format(ctx.attr.wrapper_path, tool, ctx.attr.wrapper_ext)
    return tool_path(name = tool, path = wrapped_path)

def _impl(ctx):
    tool_paths = [
        wrapper_path(ctx, "gcc"),
        wrapper_path(ctx, "ld"),
        wrapper_path(ctx, "ar"),
        wrapper_path(ctx, "cpp"),
        wrapper_path(ctx, "gcov"),
        wrapper_path(ctx, "nm"),
        wrapper_path(ctx, "objdump"),
        wrapper_path(ctx, "strip"),
    ]

    include_flags = [
        "-isystem",
        "external/{}/aarch64-none-linux-gnu/include".format(ctx.attr.gcc_repo),
        "-isystem",
        "external/{}/lib/gcc/aarch64-none-linux-gnu/{}/include".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-isystem",
        "external/{}/lib/gcc/aarch64-none-linux-gnu/{}/include-fixed".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-isystem",
        "external/{}/aarch64-none-linux-gnu/include/c++/{}/".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-isystem",
        "external/{}/aarch64-none-linux-gnu/include/c++/{}/aarch64-none-linux-gnu/".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-isystem",
        "external/{}/aarch64-none-linux-gnu/libc/usr/include/".format(ctx.attr.gcc_repo),
    ]

    linker_flags = [
        "-lstdc++",
        "-lm",
    ]

    opt_feature_flags = [
        "-g0",
        "-O2",
        "-D_FORTIFY_SOURCE=1",
        "-DNDEBUG",
        "-ffunction-sections",
        "-fdata-sections",
    ]

    dbg_feature_flags = [
        "-g",
        "-fPIC",
    ]

    fastbuild_feature_flags = [
        "-fPIC",
    ]

    opt_feature = feature(name = "opt")
    dbg_feature = feature(name = "dbg")
    fastbuild_feature = feature(name = "fastbuild")

    all_compile_actions = [
        ACTION_NAMES.c_compile,
        ACTION_NAMES.cpp_compile,
        ACTION_NAMES.linkstamp_compile,
        ACTION_NAMES.assemble,
        ACTION_NAMES.preprocess_assemble,
        ACTION_NAMES.cpp_header_parsing,
        ACTION_NAMES.cpp_module_compile,
        ACTION_NAMES.cpp_module_codegen,
        ACTION_NAMES.clif_match,
        ACTION_NAMES.lto_backend,
    ]

    compile_flag_sets = []

    compile_flag_sets.append(
        flag_set(
            actions = all_compile_actions,
            flag_groups = [
                flag_group(flags = include_flags),
            ],
        ),
    )

    compile_flag_sets.append(
        flag_set(
            actions = all_compile_actions,
            flag_groups = [
                flag_group(flags = opt_feature_flags),
            ],
            with_features = [with_feature_set(features = ["opt"])],
        ),
    )

    compile_flag_sets.append(
        flag_set(
            actions = all_compile_actions,
            flag_groups = [
                flag_group(flags = dbg_feature_flags),
            ],
            with_features = [with_feature_set(features = ["dbg"])],
        ),
    )

    compile_flag_sets.append(
        flag_set(
            actions = all_compile_actions,
            flag_groups = [
                flag_group(flags = fastbuild_feature_flags),
            ],
            with_features = [with_feature_set(features = ["fastbuild"])],
        ),
    )

    toolchain_compiler_flags = feature(
        name = "compiler_flags",
        enabled = True,
        flag_sets = compile_flag_sets,
    )

    toolchain_linker_flags = feature(
        name = "linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.cpp_link_executable,
                    ACTION_NAMES.cpp_link_dynamic_library,
                    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
                ],
                flag_groups = [
                    flag_group(flags = linker_flags),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = ctx.attr.toolchain_identifier,
        host_system_name = ctx.attr.host_system_name,
        target_system_name = "aarch64-none-linux-gnu",
        target_cpu = "aarch64-none-linux-gnu",
        target_libc = "gcc",
        compiler = ctx.attr.gcc_repo,
        abi_version = "gnu",
        abi_libc_version = ctx.attr.gcc_version,
        tool_paths = tool_paths,
        features = [
            opt_feature,
            dbg_feature,
            fastbuild_feature,
            toolchain_compiler_flags,
            toolchain_linker_flags,
        ],
    )

cc_aarch64_linux_gnu_config = rule(
    implementation = _impl,
    attrs = {
        "toolchain_identifier": attr.string(default = ""),
        "host_system_name": attr.string(default = ""),
        "wrapper_path": attr.string(default = ""),
        "wrapper_ext": attr.string(default = ""),
        "gcc_repo": attr.string(default = ""),
        "gcc_version": attr.string(default = ""),
    },
    provides = [CcToolchainConfigInfo],
)
