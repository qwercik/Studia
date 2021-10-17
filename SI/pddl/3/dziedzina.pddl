(define
	(domain world-of-blocks)
	(:requirements :adl)
	(:predicates
	    (cos-jest-podniesione)
	    (jest-podniesione ?x)
	    (na-ziemi ?x)
	    (lezy-na ?x ?y)
	    (puste ?x)
	)
	
	(:action podnies-z-ziemi
		:parameters (?x)
		:precondition
		(and
			(not (cos-jest-podniesione))
			(na-ziemi ?x)
			(puste ?x)
		)
		:effect
		(and
			(cos-jest-podniesione)
			(jest-podniesione ?x)
			(not (na-ziemi ?x))
		)
	)
	
	(:action podnies-ze-stosu
	    :parameters (?x ?y)
	    :precondition
	    (and
	        (not (cos-jest-podniesione))
	        (lezy-na ?x ?y)
	        (puste ?x)
	    )
	    :effect
	    (and
	        (cos-jest-podniesione)
	        (jest-podniesione ?x)
	        (not (lezy-na ?x ?y))
	        (puste ?y)
	    )
	)
	
	(:action opusc-na-ziemie
    	:parameters (?x)
    	:precondition
    	(and
    	    (jest-podniesione ?x)
    	)
    	:effect
    	(and
    	    (not (cos-jest-podniesione))
    	    (not (jest-podniesione ?x))
    	    (na-ziemi ?x)
    	)
	)
	
	(:action opusc-na-stos
	    :parameters (?y ?x)
	    :precondition
	    (and
	        (jest-podniesione ?x)
	        (not (jest-podniesione ?y))
	        (puste ?y)
	    )
	    :effect
	    (and
	        (not (cos-jest-podniesione))
    	    (not (jest-podniesione ?x))
	        (lezy-na ?x ?y)
	        (not (puste ?y))
	    )
	)
)

