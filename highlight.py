import sys
from pygments import highlight
from pygments.lexers import get_lexer_for_filename
from pygments.formatters import HtmlFormatter

def resolve_filename(filename) -> str:
    filename_split = filename.lower().split(".")
    extension = filename_split[-1]
    match extension:
        case 'rust':
            return ".".join(filename_split[:-1]) + ".rs"
        case 'plantuml':
            return ".".join(filename_split[:-1]) + ".puml"
        case '':
            return ".".join(filename_split[:-1]) + ".txt"
        case _:
            return filename

with open(sys.argv[1], "r") as file:
    outfile = "out" + sys.argv[2] + ".html"
    with open(outfile, "w") as outfile:
        code = file.read()
        style="default"
        if (len(sys.argv) == 4):
            style = sys.argv[3]
        highlight(code, get_lexer_for_filename(resolve_filename(sys.argv[1])), HtmlFormatter(noclasses=True,style=style), outfile)
