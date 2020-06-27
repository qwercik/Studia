liczba_jako_suma_kwadratow(N, L) :-
	liczba_jako_suma_kwadratow(N, N, L)
.

liczba_jako_suma_kwadratow(N, D, [D]) :-
	D * D =:= N,
	!
.

liczba_jako_suma_kwadratow(N, D, Lista) :-
	D * D > N,
	!,
	D1 is D - 1,
	liczba_jako_suma_kwadratow(N, D1, Lista)
.

liczba_jako_suma_kwadratow(N, D, [D | Lista]) :-
	N1 is N - D * D,
	liczba_jako_suma_kwadratow(N1, D, Lista)
.

lista__sumy_kwadratow([], []) :- !.
lista__sumy_kwadratow([H1 | T1], [H2 | T2]) :-
	liczba_jako_suma_kwadratow(H1, HH1),
	suma(HH1, H2),
	lista__sumy_kwadratow(T1, T2)
.

suma([], 0) :- !.
suma([H | T], N) :-
	suma(T, N1),
	N is N1 + H
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :-
	scal(T1, T2, T)
.

min([[K, X]], [K, X]) :- !.
min([[K, X] | T], M) :-
	min(T, M),
	[K1, _] = M,
	K1 < K,
	!
.
min([[K, X] | _], [K, X]) :- !.

zadanie(Lista, Wynik) :-
	lista__sumy_kwadratow(Lista, Lista1),
	scal(Lista1, Lista, Scalona),
	min(Scalona, [_, Wynik])
.
