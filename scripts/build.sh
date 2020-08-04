#!/bin/bash

# This script packages Warm Reception.
#
# Usage: ./scripts/build.sh

set -e

filename=warm-reception-$(git describe --abbrev=0 --tags).pk3

rm  -f "$filename"
zip -R "$filename" "*.md" "*.txt" "*.zs"
gzdoom "$filename" "$@"
