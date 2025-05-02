#!/bin/bash

readonly SCRIPTNAME="$0"
readonly HEADING=$(/bin/grep "$1" -m1 -oPe "[^# ].*")
readonly OUTDIR=${2:-"./thoughts_gen"}
readonly OUTFILE="$OUTDIR/$HEADING.html"

log() {
  echo "$SCRIPTNAME: " $1
}

codeblock() {
  IFS=$'`'
  filecnt=0
  CODEBLOCKS=$(cat "$1" | awk -f ./codeblock_filter.awk)
  mkdir -p "./thoughts_gen/codeblocks/$HEADING"
  rm -rf "./thoughts_gen/codeblocks/$HEADING/*" || true
  for i in $CODEBLOCKS; do 
    if [ -n "$(echo $i | tr -d ' \n')" ]; then 
      arr_ready_str="$(awk "//; /^[[:space:]]*\$/{print \" \";}" <<< "$i")" # preserve empty lines by printing a space
      IFS=$'\n'
      cb_lang=($arr_ready_str)
      IFS=$'`'
      printf "%s\n" "${cb_lang[@]:1:$((${#cb_lang[@]}-2))}" > "out.$cb_lang" # whatever this does
      if [[ "$cb_lang" != "text" ]]; then
        python highlight.py "out.$cb_lang" "$filecnt" "monokai"
      else
        sed -e "1 i <pre>" -e "\$ a </pre>" "out.$cb_lang" > "out$filecnt.html"
      fi
      rm "out.$cb_lang"
      mv "out$filecnt.html" "./thoughts_gen/codeblocks/$HEADING/"
      filecnt=$(($filecnt + 1))
    fi
  done
}

# ig it's bad practice if the html generator changes the source files, but whatever
if [ "$(head -1 "$1")" == "---" ]; then
  sed -si "1,7 d" "$1"
fi

codeblock "$1"

# one sed command to rule them all
cat "$1" | awk -f ./codeblock_replace.awk -v heading="$HEADING" | awk -f ./tag_bounds.awk | sed -E -f ./tags.sed >> "$OUTFILE"
