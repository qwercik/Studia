% Dodatkowy programik własnego pomysłu ;)
% Mamy wybory (28.06), więc fajnie byłoby zrobić program liczący głosy!

% generate_histogram(List, Histogram)
generate_histogram([], []) :- !.
generate_histogram([Head | Tail], Histogram) :-
	generate_histogram(Tail, TailHistogram),
	transform_histogram(Head, TailHistogram, Histogram)
.

% transform_histogram(Head, OldHistogram, NewHistogram)
transform_histogram(Head, [], [[Head, 1]]) :- !.
transform_histogram(Head, [[Head, Value] | Histogram], [[Head, NewValue] | Histogram]) :-
	NewValue is Value + 1,
	!
.
transform_histogram(DestHead, [[Head, Value] | Histogram], [[Head, Value] | NewHistogram]) :-
	transform_histogram(DestHead, Histogram, NewHistogram)
.

partition([_, _], [], [], []) :- !.
partition([PivotKey, _], [[Key, Value] | Tail], [[Key, Value] | Left], Right) :-
	Key =< PivotKey,
	!,
	partition([PivotKey, _], Tail, Left, Right)
.
partition([PivotKey, _], [[Key, Value] | Tail], Left, [[Key, Value] | Right]) :-
	partition([PivotKey, _], Tail, Left, Right)
.

quicksort_desc([], []) :- !.
quicksort_desc([Pivot | Tail], SortedList) :-
	partition(Pivot, Tail, Right, Left),
	quicksort_desc(Left, LeftSorted),
	quicksort_desc(Right, RightSorted),
	append(LeftSorted, [Pivot], LeftSortedWithPivot),
	append(LeftSortedWithPivot, RightSorted, SortedList)
.

swap_in_pair([], []) :- !.
swap_in_pair([[H1, H2] | T1], [[H2, H1] | T2]) :- 
	swap_in_pair(T1, T2)
.

sum_all_votes([], 0) :- !.
sum_all_votes([[_, Votes] | Tail], Sum) :-
	sum_all_votes(Tail, TailSum),
	Sum is Votes + TailSum
.

results_with_percents(Results, ResultsWithPercents) :-
	sum_all_votes(Results, SumOfVotes),
	results_with_percents(SumOfVotes, Results, ResultsWithPercents)
.

results_with_percents(_, [], []) :- !.
results_with_percents(SumOfVotes, [[Candidate, Votes] | RestOfCandidates], [[Candidate, Percents] | RestOfCandidatesWithPercents]) :-
	Percents is round((Votes * 100 / SumOfVotes) * 100) / 100,
	results_with_percents(SumOfVotes, RestOfCandidates, RestOfCandidatesWithPercents)
.

voting_results(Votes, Results) :-
	generate_histogram(Votes, Histogram),
	swap_in_pair(Histogram, SwappedHistogram),
	quicksort_desc(SwappedHistogram, SortedHistogram),
	swap_in_pair(SortedHistogram, SortedHistogram2),
	results_with_percents(SortedHistogram2, Results)
.


