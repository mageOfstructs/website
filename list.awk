BEGIN {
  currently_in_ulist = 0;
  currently_in_olist = 0;
}

function check_ulist_end() {
  if (currently_in_ulist == 1)
    print "</ul>";
  currently_in_ulist = 0;
}

function check_olist_end() {
  if (currently_in_olist == 1) {
    print "</ol>";
  }
  currently_in_olist = 0;
}

function check_list_end() {
  check_ulist_end();
  check_olist_end();
}

/^- .*$/ {
  check_olist_end();
  if (currently_in_ulist == 0) 
    print "<ul>";
  currently_in_ulist = 1;
  print;
}

/^[0-9]+\. .*$/ {
  check_ulist_end();
  if (currently_in_olist == 0) 
    print "<ol>";
  currently_in_olist = 1;
  print;
}

/^[^-[0-9]].*$/ {
  check_list_end();
  currently_in_olist = 0;
  currently_in_ulist = 0;
  print;
}

END {
  check_list_end();
}
