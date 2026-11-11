#!/bin/bash
set -euo pipefail

# This wrapper and the compiler archive it wraps are fetched and generated together by
# the same repository rule, so finding the archive is a fixed, one-level traversal from
# this script's own location -- no repository name of any kind is ever needed. The location
# is taken after resolving symlinks, since a caller may run the wrapper through a link
# elsewhere (bazel's coverage runner links it as <coverage dir>/gcov).
archive_dir="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.." && pwd)"

exec "${archive_dir}/usr/bin/%{real_binary}%" "$@"
