% For simplicity I assume numbering lists from 1

index([H | _], 1, H) :- !.
index([_ | T], N, H) :-
	NN is N - 1,
	index(T, NN, H)
.

split(List, 1, [], List) :- !.
split([H | List], N, [H | Left], Right) :-
	N > 1,
	N1 is N - 1,
	split(List, N1, Left, Right)
.

swap(List, Index, Index, List) :- !.
swap(List, Index1, Index2, Result) :-
	Index1 > Index2,
	!,
	swap(List, Index2, Index1, Result)
.
swap(List, Index1, Index2, Result) :-
	split(List, Index2, CenterLeft, [AtIndex2 | Right]),
	split(CenterLeft, Index1, Left, [AtIndex1 | Center]),
	append(Left, [AtIndex2 | Center], NewLeftCenter),
	append(NewLeftCenter, [AtIndex1 | Right], Result)
.

swap_if_necessary(List, ShouldBeParentIndex, ShouldBeChildIndex, Result) :-
	index(List, ShouldBeParentIndex, ShouldBeParent),
	index(List, ShouldBeChildIndex, ShouldBeChild),
	swap_if_necessary__backend(List, ShouldBeParentIndex, ShouldBeParent, ShouldBeChildIndex, ShouldBeChild, Result)
.

swap_if_necessary__backend(List, _, ShouldBeParent, _, ShouldBeChild, List) :-
	ShouldBeChild =< ShouldBeParent,
	!
.
swap_if_necessary__backend(List, ShouldBeParentIndex, _, ShouldBeChildIndex, _, Result) :-
	swap(List, ShouldBeParentIndex, ShouldBeChildIndex, Result)
.


% fix_heap(List, ListSize, Root, Result)
fix_heap(List, _, 0, List) :- !.
fix_heap(List, ListSize, Root, List) :-
	% Node has no children
	Root * 2 > ListSize,
	!
.
fix_heap(List, ListSize, Root, Result) :-
	% Node has only left child
	Left is Root * 2,
	Left + 1 > ListSize,
	swap_if_necessary(List, Root, Left, TemporaryResult),
	fix_heap(TemporaryResult, ListSize, Left, Result),
	!
.
fix_heap(List, ListSize, Root, Result) :-
	Left is Root * 2,
	Right is Root * 2 + 1,
	swap_if_necessary(List, Root, Left, TemporaryResult1),
	swap_if_necessary(TemporaryResult1, Root, Right, TemporaryResult2),
	fix_heap(TemporaryResult2, ListSize, Left, TemporaryResult3),
	fix_heap(TemporaryResult3, ListSize, Right, Result)
.

fix_whole_heap(List, ListSize, Result) :-
	Root is div(ListSize, 2),
	fix_whole_heap__backend(List, ListSize, Root, Result)
.

fix_whole_heap__backend(List, _, 0, List) :- !.
fix_whole_heap__backend(List, ListSize, Root, Result) :-
	fix_heap(List, ListSize, Root, TempResult),	
	NewRoot is Root - 1,
	fix_whole_heap__backend(TempResult, ListSize, NewRoot, Result)
.

heap_sort([], []) :- !.
heap_sort(List, Result) :-
	length(List, ListSize),
	fix_whole_heap(List, ListSize, Heap),
	heap_sort__backend(Heap, ListSize, Result)
.

heap_sort__backend(Heap, 0, Heap) :- !.
heap_sort__backend(Heap, ListSize, Result) :-
	swap(Heap, 1, ListSize, TempResult),
	NewListSize is ListSize - 1,
	fix_heap(TempResult, NewListSize, 1, TempResult2),
	heap_sort__backend(TempResult2, NewListSize, Result)
.
