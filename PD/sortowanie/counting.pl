create_n_size_list(0, _, []) :- !.
create_n_size_list(N, V, [V | L]) :- N > 0, NN is N - 1, create_n_size_list(NN, V, L).

increment_nth_cell([H | InputList], 0, [NH | InputList]) :- NH is H + 1, !.
increment_nth_cell([H | InputList], N, [H | OutputList]) :- N > 0, NN is N - 1, increment_nth_cell(InputList, NN, OutputList).

fill_histogram_from_list([], _, _, H, H) :- !.
fill_histogram_from_list([H | T], Begin, End, OldHistogram, Histogram) :-
	Index is H - Begin,
	increment_nth_cell(OldHistogram, Index, NewHistogram),
	fill_histogram_from_list(T, Begin, End, NewHistogram, Histogram)
.

create_list_from_histogram([], _, _, []) :- !.
create_list_from_histogram([0 | Histogram], Begin, End, List) :- NewBegin is Begin + 1, create_list_from_histogram(Histogram, NewBegin, End, List).
create_list_from_histogram([H | Histogram], Begin, End, [Begin | List]) :- H > 0, HH is H - 1, create_list_from_histogram([HH | Histogram], Begin, End, List).

minimum([X], X) :- !.
minimum([H | T], H) :- minimum(T, M), H =< M, !.
minimum([H | T], M) :- minimum(T, M).

maximum([X], X) :- !.
maximum([H | T], H) :- maximum(T, M), H >= M, !.
maximum([H | T], M) :- maximum(T, M).

counting_sort(List, SortedList) :-
	minimum(List, Begin),
	maximum(List, End),
	Size is End - Begin + 1,
	create_n_size_list(Size, 0, EmptyHistogram),
	fill_histogram_from_list(List, Begin, End, EmptyHistogram, Histogram),
	create_list_from_histogram(Histogram, Begin, End, SortedList)
.

