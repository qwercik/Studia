BEGIN {
    printf("") > "holiday"
    printf("") > "oncemore"
    printf("") > "simulate"

    while ((getline < "students") > 0) {
        students[$3] = $1 " " $2
    }

    while ((getline < "results") > 0) {
        results[$1] = $2
    }

    for (student in students) {
        if (student in results) {
            if (results[student] >= 3.0) {
                print students[student] >> "holiday"
            } else {
                print students[student] >> "oncemore"
            }
        } else {
            print students[student] >> "simulate"
        }
    }
}
