(define (problem p1)
	(:domain world-of-blocks)
	(:objects a b c d e)
	(:init
		(na-ziemi a)
		(na-ziemi d)
		(lezy-na b a)
		(lezy-na c b)
		(lezy-na e d)
		(puste c)
		(puste e)
	)
	(:goal
		(and
			(na-ziemi a)
    		(na-ziemi b)
    		(na-ziemi c)
    		(na-ziemi d)
    		(na-ziemi e)
		)
	)
)


