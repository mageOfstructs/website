s/\*\*([^*]*)\*\*/<b>\1<\/b>/g # bold
s/\*([^*]*)\*/<i>\1<\/i>/g # italic
s/- (.*)$/<li>\1<\/li>/ # list items

s/^###### (.*)/<h6>\1<\/h6>/
s/^##### (.*)/<h5>\1<\/h5>/
s/^#### (.*)/<h4>\1<\/h4>/
s/^### (.*)/<h3>\1<\/h3>/
s/^## (.*)/<h2>\1<\/h2>/
/^# /d # remove main heading, those are parsed somewhere else

s/`([^`]*)`/<code>\1<\/code>/g

s/!\[([^\]*)\]\(([^\)]*)\)/<img src=\"\2\" alt=\"\1\">/g # images, needs to be before links
s/\[([^\(\[]*)\]\(([^\(\[\)]*)\)/<a href=\"\2\">\1<\/a>/g # links
s/^>[[:space:]]*(.*)/\1/ # so blockquotes are nice and clean
s/\[\[(.*)\]\]/<a href=\"\/thoughts\/\1.html\">\1<\/a>/g # for the cool obsidian-like links
