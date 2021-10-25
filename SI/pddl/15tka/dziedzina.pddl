; Rozwiązanie łamigłówki bazuje na pewnej modyfikacji problemu, sprowadzającego go do problemu równoważnego
; Pomysłem jest zastąpienie pustego miejsca przez dodatkowy klocek (w przypadku łamigłówki 3x3 jest to klocek k9)
; Klocek ten jest określony jako fałszywy
; W łamigłówce występuje tylko jedna możliwa operacja - jest to zamiana miejscami klocka fałszywego z którymś z sąsiadujących klocków

(define
    (domain merry)
    (:requirements :adl)
    (:predicates
        (pionowo ?gorny ?dolny)
        (poziomo ?lewy ?prawy)
        (falszywy ?klocek)
        (na ?klocek ?pole)
    )
    (:action przesun
        :parameters (?klocek ?falszywy ?skad ?gdzie)
        :precondition (and
            (na ?klocek ?skad)
            (na ?falszywy ?gdzie)
            (falszywy ?falszywy)
            (or
                (pionowo ?skad ?gdzie)
                (pionowo ?gdzie ?skad)
                (poziomo ?skad ?gdzie)
                (poziomo ?gdzie ?skad)
            )
        )
        :effect (and
            (not (na ?klocek ?skad))
            (not (na ?falszywy ?gdzie))
            (na ?klocek ?gdzie)
            (na ?falszywy ?skad)
        )
    )
)

