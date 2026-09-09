"""Generates a companion repository holding one compiler archive's wrapper scripts
together with its cc_toolchain/cc_toolchain_config declarations.

Why this exists: cc_common resolves a cc_toolchain's tool_path strings relative to the
package of the cc_toolchain target itself, and tool_path takes a plain string rather
than a Label, so it has no way to reach into a different repository. The wrapper
scripts a tool_path names therefore have to live in the same repository as the
cc_toolchain that names them -- but the compiler binaries they wrap come from a
separately http_archive-fetched repository whose on-disk directory takes a canonical
bzlmod name this repo can't predict ahead of time (it differs by Bazel major version and
by the module's place in the dependency graph). This rule bridges the two without
touching that fetch: it takes a label into the archive repo purely to read its
Label.workspace_root (the archive's execroot-relative path, which Bazel always computes
correctly, regardless of the canonical name in use), bakes that string into each
generated wrapper script, and writes the cc_toolchain/cc_toolchain_config declarations
into the same generated repository so tool_path resolves locally, with no runtime
discovery of the archive's name needed at all.
"""

_WRAPPER_TEMPLATES = "//toolchain/templates:{}.sh.tpl"

def _gen_wrapper(rctx, out_name, template, real_binary, archive_workspace_root, extra_subs = {}):
    subs = {
        "%{archive_workspace_root}%": archive_workspace_root,
        "%{real_binary}%": real_binary,
    }
    subs.update(extra_subs)
    rctx.template(
        "wrappers/" + out_name,
        Label(_WRAPPER_TEMPLATES.format(template)),
        substitutions = subs,
        executable = True,
    )

def _cc_wrapper_repo_impl(rctx):
    archive_root = rctx.attr.archive.workspace_root
    archive = rctx.attr.archive_apparent_name
    prefix = rctx.attr.prefix
    version = rctx.attr.gcc_version
    is_cross = rctx.attr.variant == "cross"
    libpath_template = "wrapper_cross_libpath" if is_cross else "wrapper_native_hostlibs"
    gcc_template = "wrapper_gcc_cross" if is_cross else "wrapper_gcc_native"

    def gen(out_name, template, real_binary, extra_subs = {}):
        _gen_wrapper(rctx, out_name, template, real_binary, archive_root, extra_subs)

    gen(prefix + "-ar", libpath_template, prefix + "-ar")
    gen(prefix + "-as", libpath_template, prefix + "-as")
    gen(prefix + "-strip", libpath_template, prefix + "-strip")
    gen(prefix + "-objcopy", libpath_template, prefix + "-objcopy")
    gen(prefix + "-cpp", "wrapper_plain", prefix + "-cpp-" + version)
    gen(prefix + "-gcov", "wrapper_plain", prefix + "-gcov-" + version)
    gen(prefix + "-ld", "wrapper_plain", prefix + "-ld")
    gen(prefix + "-nm", "wrapper_plain", prefix + "-nm")
    gen(prefix + "-objdump", "wrapper_plain", prefix + "-objdump")
    gen("ld.gold", "wrapper_plain", prefix + "-ld.gold")

    gcc_extra = {} if is_cross else {"%{lib_arch}%": prefix}
    gen(prefix + "-gcc", gcc_template, prefix + "-gcc-" + version, gcc_extra)

    # Only the native archives declare host_libraries as a linker_files input; the cross
    # archive's linker_files has never needed it (host_libraries is already declared via
    # ar_files/as_files there), and adding it would be a behavior change, not a port.
    linker_host_libraries = "" if is_cross else '        "@{archive}//:host_libraries",\n'.format(archive = archive)

    build_content = """\
load("@aarch64_linux_gnu//toolchain:config.bzl", "cc_linux_gnu_config")
load("@rules_cc//cc:defs.bzl", "cc_toolchain")

package(default_visibility = ["//visibility:public"])

filegroup(name = "empty", srcs = [])

exports_files(glob(["wrappers/*"]))

filegroup(
    name = "ar_files",
    srcs = [
        "wrappers/{prefix}-ar",
        "@{archive}//:ar",
        "@{archive}//:host_libraries",
    ],
)

filegroup(
    name = "as_files",
    srcs = [
        "wrappers/{prefix}-as",
        "@{archive}//:as",
        "@{archive}//:host_libraries",
    ],
)

filegroup(
    name = "compiler_files",
    srcs = [
        "wrappers/{prefix}-gcc",
        ":as_files",
        "@{archive}//:compiler_pieces",
        "@{archive}//:gcc",
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "wrappers/{prefix}-gcc",
        "wrappers/{prefix}-ld",
        "wrappers/ld.gold",
        "@{archive}//:ar",
        "@{archive}//:compiler_pieces",
        "@{archive}//:gcc",
{linker_host_libraries}\
        "@{archive}//:ld",
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "wrappers/{prefix}-objcopy",
        "@{archive}//:host_libraries",
        "@{archive}//:objcopy",
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "wrappers/{prefix}-strip",
        "@{archive}//:host_libraries",
        "@{archive}//:strip",
    ],
)
""".format(prefix = prefix, archive = archive, linker_host_libraries = linker_host_libraries)

    rctx.file("BUILD.bazel", build_content + rctx.attr.build_extra)

cc_wrapper_repo = repository_rule(
    implementation = _cc_wrapper_repo_impl,
    attrs = {
        "archive": attr.label(mandatory = True, doc = "Anchor target in the fetched compiler archive repo; used only for its Label.workspace_root."),
        "archive_apparent_name": attr.string(mandatory = True, doc = "The archive repo's apparent name, as bound by use_repo in this module's own MODULE.bazel."),
        "variant": attr.string(mandatory = True, values = ["cross", "native"]),
        "prefix": attr.string(mandatory = True, doc = 'Target-triple prefix, e.g. "aarch64-linux-gnu".'),
        "gcc_version": attr.string(mandatory = True),
        "build_extra": attr.string(mandatory = True, doc = "Additional BUILD.bazel content: cc_toolchain and cc_linux_gnu_config declarations specific to this archive."),
    },
)
