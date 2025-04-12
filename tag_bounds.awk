BEGIN {
  # constants
  INDENT_UNIT = 2;

  # tag states
  currently_in_ulist = 0;
  currently_in_olist = 0;
  currently_in_bquote = 0;

  # additional state for nesting 
  prev_nested_level = 0;
}

function print_otag(tagname) {
    printf "%s","<" tagname ">";
    if (tagname == "blockquote")
      print "";
}

function print_ctag(tagname) {
    if (tagname == "blockquote")
      print "";
    printf "%s","</" tagname ">";
}

function handle_tag_bounds(tagname, rtrigger, state,   ret) {
  ret = state;
  if (ret) { # very scary to put this here
    handle_tag_bounds_rec(tagname, rtrigger, state);
  }
  if ($0 ~ rtrigger && state == 0) {
    print_otag(tagname);
    ret = 1;
  } else if (!($0 ~ rtrigger) && state == 1) {
    print_ctag(tagname);
    ret = 0;
  }
  return ret;
}

function handle_tag_bounds_rec(tagname, rtrigger, state,   nested_level) {
  if (match($0, /^[[:space:]]*/)) {
    nested_level = RLENGTH;
  }
  if (nested_level > prev_nested_level) {
    print_otag(tagname);
  } else if (nested_level < prev_nested_level) {
    for (i=prev_nested_level; i>nested_level; i-=INDENT_UNIT) {
      print_ctag(tagname);
    }
  }
  prev_nested_level = nested_level;
}

// {
  currently_in_ulist = handle_tag_bounds("ul", @/^[[:space:]]*- .*$/, currently_in_ulist);
  currently_in_olist = handle_tag_bounds("ol", @/^[0-9]+\..*$/, currently_in_olist);
  currently_in_bquote = handle_tag_bounds("blockquote", @/^>.*$/, currently_in_bquote);
  print;
}

END {
  if (currently_in_bquote == 1)
    print "\n</blockqoute>";
  
  if (currently_in_ulist == 1) {
    printf "%s","</ul>";
    for (i=prev_nested_level; i>0; i-=INDENT_UNIT) {
      printf "%s","</ul>";
    }
  }
  if (currently_in_olist == 1)
    printf "%s","</ol>";
}
