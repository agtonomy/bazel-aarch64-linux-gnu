"""Fetches one compiler archive and generates its wrapper scripts and
cc_toolchain/cc_toolchain_config declarations in that same repository.

Why this is one rule rather than an http_archive plus a separate wrapper-generating
rule: cc_common resolves a cc_toolchain's tool_path strings relative to the package of
the cc_toolchain target itself, and tool_path takes a plain string rather than a Label,
so it has no way to reach into a different repository. A wrapper script named by
tool_path therefore has to live in the same repository as the cc_toolchain that names
it -- and by fetching the archive and writing the wrappers into the same repository,
finding the archive from a wrapper script becomes a fixed, one-level, name-independent
traversal (the wrapper's own directory's parent), rather than something that has to
name a separately-fetched repository's canonical bzlmod name, which differs by Bazel
major version and by the module's place in the dependency graph.

The raw filegroups (gcc/ar/ld/... binaries, headers, libraries, host_libraries) are kept
in their own static BUILD template per variant (toolchain/ubuntu-22.04-arm64-cross.BUILD,
toolchain/ubuntu-22.04-native.BUILD) and read in verbatim, rather than reimplemented
here: those glob patterns were tuned carefully to declare every file gcc and ld reach at
action time (see README.hacks), and copying the file's text avoids re-deriving that.
"""

_WRAPPER_TEMPLATES = "//toolchain/templates:{}.sh.tpl"

def _gen_wrapper(rctx, out_name, template, real_binary, extra_subs = {}):
    subs = {"%{real_binary}%": real_binary}
    subs.update(extra_subs)
    rctx.template(
        "wrappers/" + out_name,
        Label(_WRAPPER_TEMPLATES.format(template)),
        substitutions = subs,
        executable = True,
    )

def _cc_archive_repo_impl(rctx):
    rctx.download_and_extract(
        url = rctx.attr.urls,
        sha256 = rctx.attr.sha256,
        stripPrefix = rctx.attr.strip_prefix,
    )

    prefix = rctx.attr.prefix
    version = rctx.attr.gcc_version
    is_cross = rctx.attr.variant == "cross"
    libpath_template = "wrapper_cross_libpath" if is_cross else "wrapper_native_hostlibs"
    gcc_template = "wrapper_gcc_cross" if is_cross else "wrapper_gcc_native"

    def gen(out_name, template, real_binary, extra_subs = {}):
        _gen_wrapper(rctx, out_name, template, real_binary, extra_subs)

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
    linker_host_libraries = "" if is_cross else '        ":host_libraries",\n'

    raw_content = rctx.read(rctx.attr.raw_build_file)

    generated_content = """
filegroup(name = "empty", srcs = [])

exports_files(glob(["wrappers/*"]))

filegroup(
    name = "ar_files",
    srcs = [
        "wrappers/{prefix}-ar",
        ":ar",
        ":host_libraries",
    ],
)

filegroup(
    name = "as_files",
    srcs = [
        "wrappers/{prefix}-as",
        ":as",
        ":host_libraries",
    ],
)

filegroup(
    name = "compiler_files",
    srcs = [
        "wrappers/{prefix}-gcc",
        ":as_files",
        ":compiler_pieces",
        ":gcc",
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "wrappers/{prefix}-gcc",
        "wrappers/{prefix}-ld",
        "wrappers/ld.gold",
        ":ar",
        ":compiler_pieces",
        ":gcc",
{linker_host_libraries}\
        ":ld",
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "wrappers/{prefix}-objcopy",
        ":host_libraries",
        ":objcopy",
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "wrappers/{prefix}-strip",
        ":host_libraries",
        ":strip",
    ],
)
""".format(prefix = prefix, linker_host_libraries = linker_host_libraries)

    loads = """\
load("@aarch64_linux_gnu//toolchain:config.bzl", "cc_linux_gnu_config")
load("@rules_cc//cc:defs.bzl", "cc_toolchain")

"""

    rctx.file("BUILD.bazel", loads + raw_content + generated_content + rctx.attr.build_extra)

cc_archive_repo = repository_rule(
    implementation = _cc_archive_repo_impl,
    attrs = {
        "urls": attr.string_list(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "strip_prefix": attr.string(mandatory = True),
        "raw_build_file": attr.label(mandatory = True, allow_single_file = True, doc = "Static BUILD template with the archive's raw gcc/ar/ld/headers/libraries filegroups, copied in verbatim."),
        "variant": attr.string(mandatory = True, values = ["cross", "native"]),
        "prefix": attr.string(mandatory = True, doc = 'Target-triple prefix, e.g. "aarch64-linux-gnu".'),
        "gcc_version": attr.string(mandatory = True),
        "build_extra": attr.string(mandatory = True, doc = "Additional BUILD.bazel content: cc_toolchain and cc_linux_gnu_config declarations specific to this archive."),
    },
)
