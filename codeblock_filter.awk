BEGIN {
  currently_in_codeblock = 0;
}

/```/ {
  currently_in_codeblock = !currently_in_codeblock;
  if (currently_in_codeblock == 0) print;
}

// {
  if (currently_in_codeblock == 1) {
    print;
  }
}

END {
  if (currently_in_codeblock == 1) {
    print;
  }
}
