merge(L, [], L) :- !.
merge([], L, L) :- !.
merge([H1 | T1], [H2 | T2], [H1 | M]) :-
	H1 =< H2,
	!,
	merge(T1, [H2 | T2], M)
.
merge([H1 | T1], [H2 | T2], [H2 | M]) :-
	merge([H1 | T1], T2, M)
.

half(List, Left, Right) :-
	append(Left, Right, List),
	length(Left, Length),
	length(Right, Length),
	!
.
half([H | List], [H | Left], Right) :-
	half(List, Left, Right)
.

merge_sort([], []) :- !.
merge_sort([X], [X]) :- !.
merge_sort(List, Result) :-
	half(List, Left, Right),
	merge_sort(Left, LeftSorted),
	merge_sort(Right, RightSorted),
	merge(LeftSorted, RightSorted, Result)
.
