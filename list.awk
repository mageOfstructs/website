BEGIN {
  currently_in_ulist = 0;
  currently_in_olist = 0;
}

function check_ulist_end() {
  if (currently_in_ulist == 1 && !($0 ~ /^-.*$/))
    print "</ul>";
  currently_in_ulist = $0 ~ /^-.*$/;
}

function check_olist_end() {
  if (currently_in_olist == 1 && !($0 ~ /^[0-9]+\..*$/)) {
    print "</ol>";
  }
  currently_in_olist = $0 ~ /^[0-9]+\..*$/;
}

function check_list_end() {
  check_ulist_end();
  check_olist_end();
}

/^-.*$/ {
  check_olist_end();
  if (currently_in_ulist == 0) 
    print "<ul>";
  currently_in_ulist = 1;
}

/^[0-9]+\..*$/ {
  check_ulist_end();
  if (currently_in_olist == 0) 
    print "<ol>";
  currently_in_olist = 1;
}

// {
  check_list_end();
  print
}

END {
  if (currently_in_ulist == 1)
    print "</ul>";
  if (currently_in_olist == 1)
    print "</ol>";
}
