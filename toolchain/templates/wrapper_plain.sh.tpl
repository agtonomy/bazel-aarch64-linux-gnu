#!/bin/bash
set -euo pipefail

# This wrapper lives in a small repository generated solely to hold cc_toolchain
# declarations and wrapper scripts side by side: a cc_toolchain's tool_path strings
# resolve relative to the package of the cc_toolchain target itself, with no way to
# reach into a different repository, so the wrapper can't live directly in the fetched
# compiler archive it wraps. Find the execroot from this repo's own fixed, three-level
# "external/<this repo>/wrappers/<file>" layout -- a constant this rule controls, unlike
# the archive's canonical bzlmod name -- then reach the archive via its baked-in,
# execroot-relative location (computed from Label.workspace_root at repository-fetch
# time, so it stays correct across WORKSPACE and every bzlmod canonical-name scheme).
archive_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)/%{archive_workspace_root}%"

exec "${archive_dir}/usr/bin/%{real_binary}%" "$@"
