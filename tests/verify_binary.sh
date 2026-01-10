#!/bin/bash
# Verifies that a compiled binary is a valid ELF file for the expected architecture
set -euo pipefail

BINARY="$1"
EXPECTED_ARCH="$2"

if [[ ! -f "$BINARY" ]]; then
    echo "ERROR: Binary not found: $BINARY"
    exit 1
fi

echo "Verifying: $BINARY (expecting $EXPECTED_ARCH)"

FILE_INFO=$(file "$BINARY")
echo "File info: $FILE_INFO"

# Check it's an ELF file
if [[ ! "$FILE_INFO" =~ "ELF" ]]; then
    echo "ERROR: Not an ELF file"
    exit 1
fi

# Check architecture
case "$EXPECTED_ARCH" in
    aarch64|arm64)
        if [[ ! "$FILE_INFO" =~ "ARM aarch64" ]]; then
            echo "ERROR: Expected ARM aarch64 but got: $FILE_INFO"
            exit 1
        fi
        ;;
    x86_64|x86-64)
        if [[ ! "$FILE_INFO" =~ "x86-64" ]]; then
            echo "ERROR: Expected x86-64 but got: $FILE_INFO"
            exit 1
        fi
        ;;
    *)
        echo "ERROR: Unknown architecture: $EXPECTED_ARCH"
        exit 1
        ;;
esac

echo "SUCCESS: Binary verification passed"
