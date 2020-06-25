% Początek 23:18
% Koniec 23:48

% Wydawało się proste, ale jednak było trudniejsze. Debugowanie zajęło najdłużej oczywiście ;)
% Sam się dziwię, że udało mi się wpaść na pomysł jak to zrobić. Mam nadzieję że jest dobrze, ale jakoś bardzo wnikliwie nie sprawdzałem


alfabet([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, w, v, x, y, z]).

idx(H, N) :- alfabet(Alfabet), index(H, Alfabet, N).
index(H, [H | T], 0) :- !.
index(X, [H | T], N) :- index(X, T, NN), N is NN + 1.

odl(S1, S2, D) :- idx(S1, N1), idx(S2, N2), D is abs(N2 - N1).

min(Symbol, [X], D) :-
	odl(Symbol, X, D),
	!
.

min(Symbol, [X | T], D2) :-
	min(Symbol, T, D1),
	odl(Symbol, X, D2),
	D2 =< D1,
	!
.
min(Symbol, [_ | T], D) :-
	min(Symbol, T, D)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :- scal(T1, T2, T).

partition([_, _], [], [], []) :- !.
partition([PivotKey, _], [[Key, Value] | Tail], [[Key, Value] | Lewo], Prawo) :-
	Key < PivotKey,
	!,
	partition([PivotKey, _], Tail, Lewo, Prawo)
.
partition([PivotKey, _], [[Key, Value] | Tail], Lewo, [[Key, Value] | Prawo]) :-
	partition([PivotKey, _], Tail, Lewo, Prawo)
.

quicksort([], []) :- !.
quicksort([H | T], S) :-
	partition(H, T, Lewo, Prawo),
	quicksort(Lewo, LewoPosortowane),
	quicksort(Prawo, PrawoPosortowane),
	append(LewoPosortowane, [H], LewoIPivot),
	append(LewoIPivot, PrawoPosortowane, S)
.

lista__min(_, [], []) :- !.
lista__min(T0, [H1 | T1], [H2 | T2]) :- append(T0, T1, CalaListaBezObecnego), min(H1, CalaListaBezObecnego, H2), lista__min([H1 | T0], T1, T2).

zadanie(Lista, Wynik) :-
	lista__min([], Lista, Lista2),
	scal(Lista2, Lista, Lista3),
	quicksort(Lista3, ListaPosortowana),
	scal(_, Wynik, ListaPosortowana)
.
