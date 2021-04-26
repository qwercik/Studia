{
    for (x = 1; x < NF; x++) {
        if ($x != 0) {
            if ($x != 1) {
                printf($x)
            }

            printf("x")

            if (NF - x != 1) {
                printf("^%d", NF - x)
            }

            printf("+")
        }
    }

    printf("%d\n", $NF)
}
