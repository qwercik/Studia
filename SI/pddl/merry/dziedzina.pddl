; Rozwiązanie łamigłówki bazuje na pewnej modyfikacji problemu, sprowadzającego go do problemu równoważnego
; Pomysłem jest zastąpienie pustego miejsca przez dodatkowy klocek (w przypadku łamigłówki 3x3 jest to klocek k9)
; Klocek ten jest określony jako fałszywy
; W łamigłówce występuje tylko jedna możliwa operacja - jest to zamiana miejscami klocka fałszywego z którymś z sąsiadujących klocków

(define
    (domain merry)
    (:requirements :adl)
    (:predicates
        ; Rozwiązywanie łamigłówki
        (pionowo ?gorny ?dolny)
        (poziomo ?lewy ?prawy)
        (falszywy ?klocek)
        (na ?klocek ?pole)
        
        (mozna-przejsc ?start ?koniec ?kolor)
        (kolor ?o ?kolor)
        (w ?o ?pomieszczenie)
        (aktualnie ?pomieszczenie)
        (trzymam ?o)
        (rozwiazana)
    )

    (:action przesun
        :parameters (?klocek ?falszywy ?skad ?gdzie ?pomieszczenie)
        :precondition (and
            (aktualnie ?pomieszczenie)
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
    
    (:action idz
        :parameters (?skad ?gdzie ?o ?kolor)
        :precondition (and
            (aktualnie ?skad)
            (mozna-przejsc ?skad ?gdzie ?kolor)
            (trzymam ?o)
            (kolor ?o ?kolor)
        )
        :effect (and
            (not (aktualnie ?skad))
            (aktualnie ?gdzie)
            (not (trzymam ?o))
        )
    )
    
    (:action wez
        :parameters (?kolor ?o ?pomieszczenie)
        :precondition (and
            (kolor ?o ?kolor)
            (w ?o ?pomieszczenie)
            (aktualnie ?pomieszczenie)
        )
        :effect (and
            (not (w ?o ?pomieszczenie))
            (trzymam ?o)
        )
    )
)

