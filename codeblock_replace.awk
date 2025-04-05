BEGIN {
  cidx = 0;
  is_end_of_cb = 0;
}

/^```/ {
  if (is_end_of_cb % 2 == 0) {
    print "<iframe src=./codeblocks/" heading "/out" cidx ".html></iframe>"
    cidx++;
  } 
  is_end_of_cb++;
}

// {
  if (length($0) == 0 || $0 ~ /^[^`]/)
    if (is_end_of_cb % 2 == 0)  {
      print;
    }
}
