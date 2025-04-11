#!/bin/bash
set -e

readonly SCRIPTNAME="$0"
log() {
  echo "$SCRIPTNAME: " $1
}

rm ./thoughts_gen/*.html || true
for thought in ./thoughts/*; do
  log "$thought"
  ./to_html.sh "$thought"
done

multi_page_gen() {
  mkdir -p dist/thoughts
  for thought in ./thoughts_gen/*.html; do
    heading="$(echo "$thought" | cut -c 16- | cut -d. -f1)"
    echo "<thought-div heading=\"$heading\">$(cat "$thought")</thought-div>" > tmp
    awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' ./dist/thoughts.html > "./dist/thoughts/$heading.html"
  done
  rm tmp
}

for thought in ./thoughts_gen/*.html; do
  echo "<thought-div heading=\"$(echo "$thought" | cut -c 16- | cut -d. -f1)\">$(cat "$thought")</thought-div>" >> tmp
done

awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' ./dist/thoughts.html > ./dist/thoughtlist.html
rm tmp
