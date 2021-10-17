(define (problem p1)
	(:domain world-of-blocks)
	(:objects a b c)
	(:init
	    (clear a)
	    (clear c)
	    (on-floor b)
	    (on-floor c)
	    (on-top a b)
	)
	(:goal
		(and
			(on-top a c)
		)
	)
)

