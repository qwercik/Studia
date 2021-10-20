(define
	(domain hanoi)
	(:requirements :adl)
	(:predicates
	    (mniejszy ?co ?naco)
	    (na ?co ?skad)
	    (szczyt ?co)
	    (dno ?co)
	    (pusty ?gdzie)
	    (nad ?co ?naczymlezy)
	)
	
    ; Gotowa
	(:action przenies-nieostatni-na-pusty
	    :parameters (?skad ?gdzie ?co ?naczymlezalo)
	    :precondition (and
	        (na ?co ?skad)
	        (szczyt ?co)
	        (not (dno ?co))
	        (pusty ?gdzie)
	        ; (mniejszy ?co ?naczymlezalo) ; redundancja?
	        (nad ?co ?naczymlezalo)
	    )
	    :effect (and
	        (not (na ?co ?skad))
	        (na ?co ?gdzie)
	        (not (pusty ?gdzie))
	        (dno ?co)
	        (szczyt ?naczymlezalo)
	        (not (nad ?co ?naczymlezalo))
	    )
	)
	
	; Gotowa
	(:action przenies-ostatni-na-pusty
	    :parameters (?skad ?gdzie ?co)
	    :precondition (and
	        (na ?co ?skad)
	        (szczyt ?co)
	        (dno ?co)
	        (pusty ?gdzie)
	    )
	    :effect (and
	        (not (na ?co ?skad))
	        (na ?co ?gdzie)
	        (pusty ?skad)
	        (not (pusty ?gdzie))
	    )
	)
	
	; Gotowa
	(:action przenies-ostatni-na-niepusty
	    :parameters (?skad ?gdzie ?co ?naco)
	    :precondition (and
	        (na ?co ?skad)
	        (szczyt ?co)
	        (dno ?co)
	        (not (pusty ?gdzie)) ; możliwa redundancja
	        (na ?naco ?gdzie)
	        (szczyt ?naco)
	        (mniejszy ?co ?naco)
	    )
	    :effect (and
	        (not (na ?co ?skad))
	        (na ?co ?gdzie)
	        (pusty ?skad)
	        (not (szczyt ?naco))
	        (not (dno ?co))
	        (nad ?co ?naco)
	    )
	)
	
	; Gotowa
	(:action przenies-nieostatni-na-niepusty
	    :parameters (?skad ?gdzie ?co ?naco ?naczymlezalo)
	    :precondition (and
	        (na ?co ?skad)
	        (na ?naco ?gdzie)
	        (szczyt ?co)
	        (szczyt ?naco)
	        (not (dno ?co))
	        (mniejszy ?co ?naco)
	        (nad ?co ?naczymlezalo)
	        ; (mniejszy ?co ?naczymlezalo) ;?
	    )
	    :effect (and
	        (not (na ?co ?skad))
	        (na ?co ?gdzie)
	        (szczyt ?naczymlezalo)
	        (not (szczyt ?naco))
	        (not (nad ?co ?naczymlezalo))
	        (nad ?co ?naco)
	    )
	)
)

