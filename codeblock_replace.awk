BEGIN {
  cidx = 0;
  is_end_of_cb = 0;
}

/^[[:space:]]*```/ {
  if (is_end_of_cb % 2 == 0) {
    printf "%s", "<thought-cb>"
    filename = "./thoughts_gen/codeblocks/" heading "/out" cidx ".html";
    while (getline line<filename) {
      if (!(line ~ "^(<!)?-->?") && !(line ~ "^</?(meta|html|head|body|!DOCTYPE html|title).*")) {
        print line;
      }
    }
    printf "%s", "</thought-cb>"
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
