#!/usr/bin/env bash
set -euo pipefail
IFS=$'\t\n'

readonly SRC="src/javascript.html"
readonly TARGET="dist/javascript.html"

JS_FILES="$(find src -name '*.js')"

LICENSE_HTML=()

for jsfile in ${JS_FILES[@]}; do
    JS_FILE="${jsfile##*/}"
    JS_URL="<td><a href='$JS_FILE'>$JS_FILE</a></td>"
    LICENSE_HTML+="<tr>$JS_URL<td><a href='http://www.gnu.org/licenses/gpl-3.0.html'>GNU-GPL-3.0-or-later</a></td>$JS_URL</tr>" # BUG: The LibreJS extension doesn't recognize the HTTPS version of this link and I'm too lazy to submit a bug report.
done

IFS=$'\n' LICENSE_HTML="$(echo "${LICENSE_HTML[@]}" | sed -e 's/\//\\\//g')"
sed -e "s/{JS_LICENSE_CONTENT}/${LICENSE_HTML[@]}/" $SRC > $TARGET
