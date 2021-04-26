{
    s = 0
    for (i = 3; i <= NF; i++) {
        s += $i
    }

    printf("%-10s %-15s %d\n", $1, $2, s)
}
