(define
	(domain world-of-blocks)
	(:requirements :adl)
	(:predicates
		(clear ?co)
		(on-top ?co ?gdzie)
		(on-floor ?co)
	)

	(:action przenies-paczke-z-paczki-na-podloge
		:parameters (?co ?skad)
		:precondition
		(and
			(clear ?co)
			(on-top ?co ?skad)
			(not (on-floor ?co))
			
		)
		:effect
		(and
			(clear ?skad)
			(not (on-top ?co ?skad))
			(on-floor ?co)
		)
	)
	
	(:action przenies-paczke-z-podlogi-na-paczke
	    :parameters (?co ?gdzie)
	    :precondition
	    (and
	        (clear ?co)
	        (clear ?gdzie)
	        (on-floor ?co)
	        (on-floor ?gdzie)
	    )
	    :effect
	    (and
	        (not (clear ?gdzie))
	        (not (on-floor ?co))
	        (on-top ?co ?gdzie)
	    )
	)
)

