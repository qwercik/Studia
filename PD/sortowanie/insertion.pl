insert(X, [Y | T1], [Y | T2]) :-
	X > Y,
	!,
	insert(X, T1, T2)
.
insert(X, T, [X | T]).

insertion_sort([], []) :- !.
insertion_sort([H | T], S) :-
	insertion_sort(T, T1),
	insert(H, T1, S)
.

