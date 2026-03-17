BEGIN {
    time = 0
}
/.*<time>.*/ {
    time += rand()
    sub("<time>", time, $0)
}

// {
    print;
}
