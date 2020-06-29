partition(_, [], [], []) :- !.
partition(P, [H | T], [H | L], R) :-
	H < P,
	!,
	partition(P, T, L, R)
.
partition(P, [H | T], L, [H | R]) :-
	partition(P, T, L, R)
.

quicksort([], []) :- !.
quicksort([H | T], S) :-
	partition(H, T, L, R),
	quicksort(L, LS),
	quicksort(R, RS),
	append(LS, [H], LSH),
	append(LSH, RS, S)
.
