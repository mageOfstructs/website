#!/bin/bash
set -euo pipefail
IFS="\t\n"

DOCS_PATH="$1:?need docs path"

if [[ "$DOCS_PATH" == http* ]]; then
  rm -rf tmp || true
  git clone "$DOCS_PATH" tmp
  DOCS_PATH="./tmp"
fi

./gen_blog.sh
./gen_blog.sh "$1" ./thoughts_gen/ -m
