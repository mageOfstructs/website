#!/bin/bash

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

# one sed command to rule them all
cat $1 | awk -f ./list.awk | sed -E -e "s/\*\*(.*)\*\*/<b>\1<\/b>/g" -e "s/\*(.*)\*/<i>\1<\/i>/g" -e "s/^- (.*)\$/<li>\1<\/li>/g" -e "/^#/d" > "$2"
