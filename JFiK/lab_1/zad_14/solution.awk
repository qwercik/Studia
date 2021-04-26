BEGIN {
    getline < "opis.txt"
    h = $1
    w = $2

    line1 = "x"
    line2 = "x"
    for (i = 1; i <= w - 2; i++) {
        line1 = line1 " "
        line2 = line2 "x"
    }
    line1 = line1 "x"
    line2 = line2 "x"

    err = 0
    i = 0
    while (getline < "prostokat.txt") {
        if (((i == 0 || i == h - 1) && ($0 != line2)) || (i > 0 && i < h - 1 && $0 != line1)) {
            print $0 " " i
            err = 1
            break
        }
        i++
    }

    if (h != i) {
        err = 1
    }

    if (err) {
        print "Błąd"
    } else {
        print "OK"
    }
}

