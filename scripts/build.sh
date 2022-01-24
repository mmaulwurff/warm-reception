#!/bin/bash

# This script packages Warm Reception.
#
# Usage: ./scripts/build.sh

filename=warm-reception-$(git describe --abbrev=0 --tags).pk3

rm --force "$filename"
zip --recurse-patterns -0 "$filename" "*.md" "*.txt" "*.zs"
gzdoom "$filename" "$@" > output 2>&1; cat output
