#!/bin/bash

readonly SCRIPTNAME="$0"
readonly HEADING=$(/bin/grep "$1" -m1 -oPe "[^# ].*")
readonly OUTFILE="./thoughts_gen/$HEADING.html"

log() {
  echo "$SCRIPTNAME: " $1
}

codeblock() {
  IFS=$'`'
  echo $IFS
  filecnt=0
  CODEBLOCKS=$(cat "$1" | awk -f ./codeblock_filter.awk)
  mkdir -p "./dist/codeblocks/$HEADING"
  for i in $CODEBLOCKS; do 
    if [ -n "$(echo $i | tr -d ' \n')" ]; then 
      IFS=$'\n'
      cb_lang=($i)
      IFS=$'`'
      echo "CBLANG: $cb_lang"
      echo $(echo ${#cb_lang[@]}-1 | bc)
      j=1
      while [ $j -lt ${#cb_lang[@]} ]; do
        echo "${cb_lang[$j]}" >> "out.$cb_lang"
        j=$(($j + 1))
      done
      vim --cmd "colorscheme elflord" "out.$cb_lang" -c "TOhtml" -c "w out$filecnt.html" -c "qa!"
      rm "out.$cb_lang"
      mv "out$filecnt.html" "./dist/codeblocks/$HEADING/"
      filecnt=$(($filecnt + 1))
    fi
  done
}

codeblock "$1"

# one sed command to rule them all
cat "$1" | awk -f ./codeblock_replace.awk -v heading="$HEADING" | awk -f ./tag_bounds.awk | sed -E -f ./tags.sed >> "$OUTFILE"
