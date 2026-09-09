#!/bin/bash
# Verifies that //:hello_c's compile action runs this repo's toolchain, not the host's.
#
# rules_cc registers an auto-detected host cc toolchain, and it outranks a dependency
# module's registrations, so a mis-registered toolchain silently compiles with the host's
# gcc instead of failing. Each argument pair is a --config (empty for the default
# configuration) and a string the compile command must contain.
set -euo pipefail

if [ "$#" -eq 0 ] || [ $(("$#" % 2)) -ne 0 ]; then
    echo "usage: $0 <config> <expected-substring> [<config> <expected-substring> ...]" >&2
    exit 2
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

fail=0
n=0
while [ "$#" -gt 0 ]; do
    CONFIG="$1"
    EXPECTED="$2"
    shift 2
    n=$((n + 1))

    ARGS=()
    if [ -n "$CONFIG" ]; then
        ARGS=(--config="$CONFIG")
    fi

    # aquery writes to a file rather than a pipe on purpose: `grep -q` exits at its first
    # match and closes the pipe, and the compiler path lands ~2KB from the end of a ~290KB
    # dump, so bazel is still writing when the pipe goes away. It treats that as fatal
    # ("Cannot write to standard output; exiting...") and exits 255, which pipefail then
    # reports as a mis-selected toolchain -- a race that fails only on a loaded machine.
    OUT="$TMP/aquery.$n"
    bazel aquery 'mnemonic("CppCompile", //:hello_c)' "${ARGS[@]}" --output=text > "$OUT"

    echo "Verifying: ${CONFIG:-default} (expecting $EXPECTED)"
    if grep -qF -- "$EXPECTED" "$OUT"; then
        echo "SUCCESS: toolchain verification passed"
    else
        echo "::error::${CONFIG:-default}: expected '$EXPECTED' in the compile command" >&2
        grep -m1 -oE 'exec [^ ]+' "$OUT" >&2 || true
        fail=1
    fi
done

exit "$fail"
