#!/usr/bin/env bash
set -euo pipefail
IFS=$'\t\n'

LOG_CONTENT="$(cat src/log)"
# make OK green
LOG_CONTENT="$(echo "$LOG_CONTENT" | sed -E 's/(OK)/<span class="text-green-600 font-bold">\1<\/span>/')"
# make FAILED red
LOG_CONTENT="$(echo "$LOG_CONTENT" | sed -E 's/(FAILED)/<span class="text-red-600 font-bold">\1<\/span>/')"
# add custom CSS classes
LOG_CONTENT="$(echo "$LOG_CONTENT" | sed -E 's/\((.*)\)\*(.*)$/<span class="\1">\2<\/span>/')"
LOG_CONTENT="$(echo "$LOG_CONTENT" | sed -E 's/^(.*)$/<p>\1<\/p>/')"

readonly LC_LINENUM="$(($(grep -nF '{LOG_CONTENT}' src/index.html | cut -d: -f1) - 1))"
echo "$(sed -n "1,$LC_LINENUM p" src/index.html)$LOG_CONTENT$(sed -n "$((LC_LINENUM + 2)),\$ p" src/index.html)" | awk -f ./nojs_time.awk > dist/index.html
