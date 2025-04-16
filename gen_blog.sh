#!/bin/bash
set -e

readonly SCRIPTNAME="$0"
readonly MD_SRC="${1:-./thoughts}"
readonly HTML_DST="${2:-./thoughts_gen}"
readonly ASSET_DIR="${ASSET_DIR:-"$MD_SRC/assets"}"
log() {
  echo "$SCRIPTNAME: " $1
}

init() {
  # ensure we have a syntax highlighter
  if [[ ! -a ./venv ]]; then
    python -m venv ./venv
    source ./venv/bin/activate
    pip install pygments

  fi
  
  # clean generated file dir
  # TODO: parameterize (scary)
  rm ./thoughts_gen/*.html || true
  rm tmp || true
}

init

if [[ -n "$ASSET_DIR" && -d "$ASSET_DIR" ]]; then
  cp -r "$ASSET_DIR" "./dist/" # TODO: change later
fi

for thought in $MD_SRC/*.md; do
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

for thought in $HTML_DST/*.html; do
  echo "<div class=\"thought block border border-4 border-double rounded-sm border-lime-500 p-4 font-mono bg-neutral-950 m-0 text-stone-50 w-full mb-4\"><h3 class=\"font-bold text-xl\">$(echo "$thought" | cut -c 16- | cut -d. -f1)</h3><div class=\"whitespace-pre-line\">$(cat "$thought")</div></div>" >> tmp
done

awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' ./dist/thoughts.html > ./dist/thoughtlist.html
rm tmp
