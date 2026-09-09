#!/bin/bash
set -euo pipefail

# Ensure basic shell utilities are available (needed when running under nvcc with stripped PATH)
export PATH="/bin:$PATH"

# Always resolve from script location so paths work when a caller (e.g. rules_go) chdirs:
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# This wrapper lives in a small repository generated solely to hold cc_toolchain
# declarations and wrapper scripts side by side: a cc_toolchain's tool_path strings
# resolve relative to the package of the cc_toolchain target itself, with no way to
# reach into a different repository, so the wrapper can't live directly in the fetched
# compiler archive it wraps. Find the execroot from this repo's own fixed, three-level
# "external/<this repo>/wrappers/<file>" layout -- a constant this rule controls, unlike
# the archive's canonical bzlmod name -- then reach the archive via its baked-in,
# execroot-relative location (computed from Label.workspace_root at repository-fetch
# time, so it stays correct across WORKSPACE and every bzlmod canonical-name scheme).
archive_dir="$(cd "${script_dir}/../../.." && pwd)/%{archive_workspace_root}%"

# ld (at least built and configured the way Ubuntu does,) doesn't work well with bazel's
# sandbox symlinks: gcc resolves its own binary before deriving the library search paths it
# hands to ld, so unless --sysroot names the same directory gcc resolved to, ld stops
# treating the absolute paths inside glibc's ld scripts (libc.so is a GROUP(...) script) as
# sysroot-relative and looks for them at the real root. So derive the sysroot from the
# realpath of the gcc binary itself: it is the one path guaranteed to agree with gcc under
# the symlinking sandbox, the hermetic sandbox and remote execution alike. Don't go looking
# for it with `find` either -- the archives keep Ubuntu's merged-/usr layout, so libc.so.6
# sits at more than one depth and any depth-based guess is ambiguous.
gcc_realpath="$(realpath "${archive_dir}/usr/bin/%{real_binary}%")"
sysroot="${gcc_realpath%/usr/bin/*}"

# Required so the host binaries can find shared libraries they need.
# Include usr/lib/x86_64-linux-gnu/ alongside host-libs/: the cross packages deposit
# x86_64 runtime libs there, and unlike the native archives this path has no x86_64
# libc.so.6, so there is no glibc version mixing risk.
export LD_LIBRARY_PATH="${sysroot}/usr/lib/x86_64-linux-gnu"

# Due to https://github.com/bazelbuild/bazel/issues/16222 this is the only spot we can add
# the --no-as-needed ld flag to make the final binary list every shared library provided on
# the command line as DT_NEEDED, which is required to make ld.so use the RPATH entries
# to find those libraries:

"$gcc_realpath" \
    -Wl,--no-as-needed \
    "-B${sysroot}/usr/bin/" \
    "-B${script_dir}/" \
    "$@" --sysroot="$sysroot"
