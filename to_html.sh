#!/bin/bash

readonly SCRIPTNAME="$0"
log() {
  echo "$SCRIPTNAME: " $1
}

codeblock() {
  IFS=$'`'
  echo $IFS
  filecnt=1
  CODEBLOCKS=$(grep test.md -zoe "\`\`\`.*\`\`\`")
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
      vim "out.$cb_lang" -c "TOhtml out$filecnt.html" -c "qa"
      rm "out.$cb_lang"
      filecnt=$(($filecnt + 1))
    fi
  done
}

readonly HEADING=$(/bin/grep "$1" -m1 -oPe "[^# ].*")
readonly OUTFILE="./thoughts_gen/$HEADING.html"
# one sed command to rule them all
cat "$1" | awk -f ./tag_bounds.awk | sed -E -e "s/\*\*([^*]*)\*\*/<b>\1<\/b>/g" -e "s/\*([^*]*)\*/<i>\1<\/i>/g" -e "s/^- (.*)\$/<li>\1<\/li>/g" -e "/^#/d" -e "s/\[([^\(\[]*)\]\(([^\(\[\)]*)\)/<a href=\"\2\">\1<\/a>/g" >> "$OUTFILE"
