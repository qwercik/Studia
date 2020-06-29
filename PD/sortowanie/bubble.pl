% split_at_index(List, Index, Left, Right)
split_at_index(List, 0, [], List) :- !.
split_at_index([Head | List], Index, [Head | Left], Right) :-
	Index > 0,
	NewIndex is Index - 1,
	split_at_index(List, NewIndex, Left, Right)
.

bubble_sort_partial([], []) :- !.
bubble_sort_partial([X], [X]) :- !.
bubble_sort_partial([H1, H2 | T1], [H1 | T2]) :-
	H1 =< H2,
	!,
	bubble_sort_partial([H2 | T1], T2)
.
bubble_sort_partial([H1, H2 | T1], [H2 | T2]) :-
	bubble_sort_partial([H1 | T1], T2)
.

bubble_sort([], []) :- !.
bubble_sort(List, Result) :-
	bubble_sort_partial(List, Partial),
	append(Rest, [Last], Partial),
	!,
	bubble_sort(Rest, RestSorted),
	append(RestSorted, [Last], Result),
	!
.
