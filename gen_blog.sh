#!/bin/bash
set -e

readonly SCRIPTNAME="$0"
log() {
  echo "$SCRIPTNAME: " $1
}

rm ./thoughts_gen/*.html
for thought in $(ls ./thoughts/*); do
  ./to_html.sh "$thought"
done

for thought in $(ls ./thoughts_gen/*.html); do
  echo "<thought-div heading=\"asdf\">$(cat "$thought")</thought-div>" >> tmp
done

awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' ./thoughts.html > out.html
rm tmp
