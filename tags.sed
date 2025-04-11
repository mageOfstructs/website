s/\*\*([^*]*)\*\*/<b>\1<\/b>/g # bold
s/\*([^*]*)\*/<i>\1<\/i>/g # italic
s/- (.*)$/<li>\1<\/li>/ # list items
/^#/d # remove heading, those are parsed somewhere else
s/!\[([^\]*)\]\(([^\)]*)\)/<img src=\"\2\" alt=\"\1\">/g # images, needs to be before links
s/\[([^\(\[]*)\]\(([^\(\[\)]*)\)/<a href=\"\2\">\1<\/a>/g # links
s/^>[[:space:]]*(.*)/\1/ # so blockquotes are nice and clean
s/\[\[(.*)\]\]/<a href=\"\/thoughts\/\1.md\">\1<\/a>/g # for the cool obsidian-like links
