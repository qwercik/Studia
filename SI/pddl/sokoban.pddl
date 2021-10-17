(define
    (domain sokoban)
    (:requirements :adl)
    (:predicates
        (robot ?x)
        (paczka ?x)
        (pionowo ?x ?y)
        (poziomo ?x ?y)
        (cel ?x)
    )

    (:action idz
        :parameters (?skad ?gdzie)
        :precondition
        (and
            (robot ?skad)
            (not (paczka ?gdzie))
            ; Czy może wystąpić sytuacja, kiedy robot będzie chciał przejść z miejsca na miejsce, na którym już stoi?
            (or
                (poziomo ?skad ?gdzie)
                (pionowo ?skad ?gdzie)
            )
        )
        :effect
        (and
            (not (robot ?skad))
            (robot ?gdzie)
        )
    )
    
    (:action pchaj
        :parameters (?robot ?skad-paczka ?gdzie-paczka)
        :precondition
        (and
            (robot ?robot)
            (not (robot ?gdzie-paczka)) ; Obsługujemy sytuację, żeby ?robot i ?gdzie-paczka to nie było przypadkiem to samo
            (paczka ?skad-paczka)
            (not (paczka ?gdzie-paczka))
            (or
                (and
                    (poziomo ?robot ?skad-paczka)
                    (poziomo ?skad-paczka ?gdzie-paczka)
                )
                (and
                    (pionowo ?robot ?skad-paczka)
                    (pionowo ?skad-paczka ?gdzie-paczka) 
                )
            )
        )
        :effect
        (and
            (not (robot ?robot))
            (robot ?skad-paczka)
            (not (paczka ?skad-paczka))
            (paczka ?gdzie-paczka)
        )
    )
)
