#!/bin/bash
set -euo pipefail
IFS=$'\t\n'

./gen_blog.sh

if [ $# -ge 1 ]; then
    DOCS_PATH="${1:?need docs path}"

    if [[ "$DOCS_PATH" == http* ]]; then
      rm -rf tmp &>/dev/null || true
      git clone "$DOCS_PATH" tmp
      DOCS_PATH="./tmp"
    fi

    ./gen_blog.sh "$DOCS_PATH" ./thoughts_gen/ -m
fi

./nojs.sh
./license.sh
