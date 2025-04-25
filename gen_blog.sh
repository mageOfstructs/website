#!/bin/bash
set -e
shopt -s extglob

readonly SCRIPTNAME="$0"
readonly MD_SRC="${1:-./thoughts}"
readonly HTML_DST="${2:-./thoughts_gen}"
readonly ASSET_DIR="${ASSET_DIR:-"$MD_SRC/assets"}"
log() {
  echo "$SCRIPTNAME: $1"
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
  cp ./src/* dist/
}

init

if [[ -n "$ASSET_DIR" && -d "$ASSET_DIR" ]]; then
  cp -r "$ASSET_DIR" "./dist/" # TODO: change later
fi

genhtml() {
  mkdir -p "$2"
  for thought in $1/!(*.png); do
    basename="${thought##*/}"
    if [[ "$basename" == "assets" ]]; then
      continue
    elif [[ -d "$thought" ]]; then 
      genhtml "$thought" "$2/$basename"
    else
      ./to_html.sh "$thought" "$2"
    fi
  done
}
genhtml "$MD_SRC" "$HTML_DST"

getlinenr() { # getlinenr <pattern> <file>
  echo "$(grep -m1 -nF "$1" $2 | cut -d: -f1)"
}

docentry_insertpoint="$(getlinenr '<!-- doc entries here -->' dist/docs.html)"
append_to_doc() {
  sed -si "$docentry_insertpoint a $1" dist/docs.html
  docentry_insertpoint=$(($docentry_insertpoint + 1))
}

multi_page_gen() {
  log "selected multi_page_gen"
  mkdir -p dist/thoughts
  docentry_insertpoint="$(getlinenr '<!-- doc entries here -->' dist/docs.html)"
  for thought in ./thoughts_gen/*.html; do
    thought_heading="$(echo "$thought" | cut -c 16- | cut -d. -f1)"
    echo "<div class=\"thought block border border-4 border-double rounded-sm border-lime-500 p-4 font-mono bg-neutral-950 m-0 text-stone-50 w-full mb-4\"><h1 class=\"font-bold text-3xl text-sky-600\" id=\"$thought_heading\">$thought_heading</h1><div class=\"whitespace-pre-line\">$(cat "$thought")</div></div>" >> tmp
    sed "58,70 d" dist/thoughts.html | awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' > "./dist/thoughts/$thought_heading.html"
    sed -si "$docentry_insertpoint a <li class=\"text-lime-500 hover:bg-lime-500 hover:text-neutral-950\" onclick=\"document.getElementById('content').src = 'thoughts/$thought_heading.html'\">$thought_heading</li>" dist/docs.html
    docentry_insertpoint=$(($docentry_insertpoint + 1))
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
  
  awk '//; /<!-- dynamic stuff here -->/{while(getline line<"tmp"){print line}}' ./src/thoughts.html > ./dist/thoughts.html
  rm tmp
}
page_gen $@

