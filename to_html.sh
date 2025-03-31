#!/bin/bash

# codeblock() {
#   IFS='`'
#   CODEBLOCKS=$(grep test.md -zoe "\`\`\`.*\`\`\`")
#   for i in $CODEBLOCKS; do 
#     if [ -n "$(echo $i | tr -d ' \n')" ]; then 
#       IFS='\n'
#       CODEBLOCK_LANG=$($i[0])
#       IFS='`'
#       echo $i >> out
#     fi
#   done
# }

awk -f ./list.awk <$1 > "$2"
# one sed command to rule them all
sed -E -s "$2" -e "s/\*\*(.*)\*\*/<b>\1<\/b>/g" -e "s/\*(.*)\*/<i>\1<\/i>/g" -e "s/^- (.*)\$/<li>\1<\/li>/g" -e "/^#/d" > "$2"
