import sys
from pygments import highlight
from pygments.lexers import get_lexer_for_filename
from pygments.formatters import HtmlFormatter

with open(sys.argv[1], "r") as file:
    outfile = "out" + sys.argv[2] + ".html"
    with open(outfile, "w") as outfile:
        code = file.read()
        style="default"
        if (len(sys.argv) == 4):
            style = sys.argv[3]
        highlight(code, get_lexer_for_filename(sys.argv[1]), HtmlFormatter(noclasses=True), outfile)
