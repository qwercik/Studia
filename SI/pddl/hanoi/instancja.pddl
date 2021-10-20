(define (problem p1)
	(:domain hanoi)
	(:objects x y z k1 k2 k3 k4 k5)
	(:init
	    (mniejszy k1 k2)
	    (mniejszy k1 k3)
	    (mniejszy k1 k4)
	    (mniejszy k1 k5)
	    (mniejszy k2 k3)
	    (mniejszy k2 k4)
	    (mniejszy k2 k5)
	    (mniejszy k3 k4)
	    (mniejszy k3 k5)
	    (mniejszy k4 k5)
	    
	    (na k1 x)
	    (na k2 x)
	    (na k3 x)
	    (na k4 x)
	    (na k5 x)
	    
	    (szczyt k1)
	    (dno k5)
	    
	    (pusty y)
	    (pusty z)
	    
	    (nad k1 k2)
	    (nad k2 k3)
	    (nad k3 k4)
	    (nad k4 k5)
	)
	(:goal
		(and
		    (na k1 z)
		    (na k2 z)
		    (na k3 z)
		    (na k4 z)
		    (na k5 z)
		)
	)
)

