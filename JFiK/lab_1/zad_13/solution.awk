BEGIN {
    getline < "opis.txt"
    h = $1
    w = $2

    line = ""
    for (; w >= 1; w--) {
        line = line "x"
    }

    err = 0
    while (getline < "prostokat.txt") {
        if ($0 != line) {
            err = 1
            break
        }

        h--
    }

    if (h != 0) {
        err = 1
    }

    if (err) {
        print "Błąd"
    } else {
        print "OK"
    }
}

