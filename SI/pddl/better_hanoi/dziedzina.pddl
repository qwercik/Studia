(define
    (domain hanoi)
    (:requirements :adl)
    (:predicates
        (mniejszy ?krazek1 ?krazek2)
        (na ?krazek ?pacholek)
    )
    (:action przenies
        :parameters (?skad ?gdzie ?krazek)
        :precondition (and
            (not (= ?skad ?gdzie))
            (not (exists (?pacholek) (na ?gdzie ?pacholek))) ; proste zabezpieczenie przed niezgodnością typów
            
            (na ?krazek ?skad)
            (not (exists (?inny-krazek) (and
                (or (na ?inny-krazek ?skad) (na ?inny-krazek ?gdzie))
                (mniejszy ?inny-krazek ?krazek)
            )))
        )
        :effect (and
            (not (na ?krazek ?skad))
            (na ?krazek ?gdzie)
        )
    )
)

