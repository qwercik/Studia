index([H | List], 0, H) :- !.
index([_ | List], N1, H) :-
	N is N1 - 1,
	index(List, N, H)
.

swap(List, Index, Index, List) :- !.
swap(List, Index1, Index2, Result) :-
	Index1 > Index2,
	!,
	swap_backend(List, Index2, Index1, Result)
.
swap(List, Index1, Index2, Result) :-
	swap_backend(List, Index1, Index2, Result)
.

swap_backend(List, Index1, Index2, ResultList) :-
	index(List, Index1, AtIndex1),
	index(List, Index2, AtIndex2),

	append(Left, [AtIndex1 | CenterRight], List),
	length(Left, Index1),

	append(Center, [AtIndex2 | Right], CenterRight),
	CenterLength is Index2 - Index1 - 1,
	length(Center, CenterLength),
	!,

	append(Left, [AtIndex2 | Center], NewLeftCenter),
	append(NewLeftCenter, [AtIndex1 | Right], ResultList)
.

min([H | List], Min, Index) :-
	min(List, Min, Index1),
	Min < H,
	!,
	Index is Index1 + 1
.
min([H | _], H, 0) :- !.

selection_sort([], []) :- !.
selection_sort(List, [Min | Result]) :-
	min(List, Min, Index),
	swap(List, 0, Index, [Min | Swapped]),
	selection_sort(Swapped, Result)
.
