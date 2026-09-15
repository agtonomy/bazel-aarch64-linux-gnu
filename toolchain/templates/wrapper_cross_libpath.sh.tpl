#!/bin/bash
set -euo pipefail

# This wrapper and the compiler archive it wraps are fetched and generated together by
# the same repository rule, so finding the archive is a fixed, one-level traversal from
# this script's own location -- no repository name of any kind is ever needed.
archive_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Required so the host binaries can find shared libraries they need.
# Include usr/lib/x86_64-linux-gnu/ alongside host-libs/: the cross packages deposit
# x86_64 runtime libs there, and unlike the native archives this path has no x86_64
# libc.so.6, so there is no glibc version mixing risk.
export LD_LIBRARY_PATH="${archive_dir}/usr/lib/x86_64-linux-gnu"

exec "${archive_dir}/usr/bin/%{real_binary}%" "$@"
