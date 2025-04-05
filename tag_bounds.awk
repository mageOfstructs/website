BEGIN {
  currently_in_ulist = 0;
  currently_in_olist = 0;
  currently_in_bquote = 0;
}

function handle_tag_bounds(tagname, rtrigger, state) {
  if ($0 ~ rtrigger && state == 0) {
    printf "%s","<" tagname ">";
    if (tagname == "blockquote")
      print "";
    return 1;
  } else if (!($0 ~ rtrigger) && state == 1) {
    if (tagname == "blockquote")
      print "";
    printf "%s","</" tagname ">";
    return 0;
  }
  return state;
}

// {
  currently_in_ulist = handle_tag_bounds("ul", @/^- .*$/, currently_in_ulist);
  currently_in_olist = handle_tag_bounds("ol", @/^[0-9]+\..*$/, currently_in_olist);
  currently_in_bquote = handle_tag_bounds("blockquote", @/^>.*$/, currently_in_bquote);
  print;
}

END {
  if (currently_in_ulist == 1)
    printf "%s","</ul>";
  if (currently_in_olist == 1)
    printf "%s","</ol>";
  if (currently_in_bquote == 1)
    print "\n</blockqoute>";
}
