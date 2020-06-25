% Rozpoczęto o 15:22
% Zakończono o 15:52

% Nie jest to wykonane poprawnie, ale nieszczególne chce mi się to poprawiać.
% Zostawiam komuś, bo może koncepcja go przekona ;)

% znajdz_max(Lista, ElementMax, PozycjaMax, PozycjaOstatniegoElementuNaLiscie)
znajdz_max([X], X, 0, 1) :- !.
znajdz_max([X | T], M, P, L) :- 
	znajdz_max(T, M, PP, LL),
	M > X,
	!,
	P is PP + 1,
	L is LL + 1
.
znajdz_max([X | T], X, 0, L) :-
	znajdz_max(T, _, _, L)
.

obetnij_aby_max_byl_na_srodku(Lista, Wynik) :-
	znajdz_max(Lista, _, P, L),
	obetnij_do_pozycji(Lista, P, L, _, Wynik)
.

obetnij_do_pozycji(Lista, P, L, L, Lista) :- L is P * 2, !.
obetnij_do_pozycji(Lista, P, L, L2, Wynik) :-
	C is div(L, 2),
	P < C,
	!,
	append(Lista2, [_], Lista),
	L1 is L - 1,
	obetnij_do_pozycji(Lista2, P, L1, L2, Wynik)
.
obetnij_do_pozycji([_ | Lista], P, L, L2, Wynik) :-
	L1 is L - 1,
	P1 is P - 1,
	obetnij_do_pozycji(Lista, P1, L1, L2, Wynik)
.

suma([X], X) :- !.
suma([H | T], S) :-
	suma(T, S1),
	S is S1 + H
.

srednia(Lista, Srednia) :-
	suma(Lista, S),
	length(Lista, L),
	Srednia is S / L
.

partition([_, _], [], [], []) :- !.
partition([P, _], [[K, V] | T], [[K, V] | L], R) :-
	K =< P,
	!,
	partition([P, _], T, L, R)
.
partition([P, _], [[K, V] | T], L, [[K, V] | R] ) :-
	partition([P, _], T, L, R)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :-
	scal(T1, T2, T)
.

quicksort([], []) :- !.
quicksort([H | T], S) :-
	partition(H, T, L, R),
	quicksort(L, LS),
	quicksort(R, RS),
	append(LS, [H], LSH),
	append(LSH, RS, S)
.

lista__obetnij([], []) :- !.
lista__obetnij([H1 | T1], [H2 | T2]) :-
	obetnij_aby_max_byl_na_srodku(H1, H2),
	lista__obetnij(T1, T2)
.

lista__srednie([], []) :- !.
lista__srednie([H1 | T1], [H2 | T2]) :-
	srednia(H1, H2),
	lista__srednie(T1, T2)
.

zadanie(Lista, Wynik) :-
	lista__obetnij(Lista, Lista1),
	lista__srednie(Lista1, Lista2),
	scal(Lista2, Lista, Sc),
	quicksort(Sc, Sorted),
	scal(_, Wynik, Sorted)
.
