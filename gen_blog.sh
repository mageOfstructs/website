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
  ./to_html.sh "$thought"
done

multi_page_gen() {
  log "selected multi_page_gen"
  mkdir -p dist/thoughts
  cp dist/docs.html dist/docs_gen.html
  for thought in ./thoughts_gen/*.html; do
    thought_heading="$(echo "$thought" | cut -c 16- | cut -d. -f1)"
    echo "<div class=\"thought block border border-4 border-double rounded-sm border-lime-500 p-4 font-mono bg-neutral-950 m-0 text-stone-50 w-full mb-4\"><h1 class=\"font-bold text-3xl text-sky-600\" id=\"$thought_heading\">$thought_heading</h1><div class=\"whitespace-pre-line\">$(cat "$thought")</div></div>" >> tmp
    sed "58,67 d" dist/thoughts.html | awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' > "./dist/thoughts/$thought_heading.html"
    sed -si "22 a <li class=\"text-lime-500 hover:bg-lime-500 hover:text-neutral-950\" onclick=\"document.getElementById('content').src = 'thoughts/$thought_heading.html'\">$thought_heading</li>" dist/docs_gen.html
    rm tmp
  done
}

page_gen() {
  log "$@"
  for arg in $@; do
    case "$arg" in
      -m)
        multi_page_gen
        return 0
    esac
  done
  
  for thought in $HTML_DST/*.html; do
    thought_heading="$(echo "$thought" | cut -c 16- | cut -d. -f1)"
    echo "<div class=\"thought block border border-4 border-double rounded-sm border-lime-500 p-4 font-mono bg-neutral-950 m-0 text-stone-50 w-full mb-4\"><h1 class=\"font-bold text-3xl text-sky-600\" id=\"$thought_heading\">$thought_heading</h1><div class=\"whitespace-pre-line\">$(cat "$thought")</div></div>" >> tmp
  done
  
  awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' ./dist/thoughts.html > ./dist/thoughtlist.html
  rm tmp
}
page_gen $@

