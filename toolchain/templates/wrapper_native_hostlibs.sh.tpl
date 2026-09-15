#!/bin/bash
set -euo pipefail

# This wrapper and the compiler archive it wraps are fetched and generated together by
# the same repository rule, so finding the archive is a fixed, one-level traversal from
# this script's own location -- no repository name of any kind is ever needed.
archive_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Required so the host binaries can find shared libraries they need:
[ -d "${archive_dir}/host-libs" ] && \
    export LD_LIBRARY_PATH="${archive_dir}/host-libs"

exec "${archive_dir}/usr/bin/%{real_binary}%" "$@"
