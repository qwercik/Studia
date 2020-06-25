% Rozpoczęto 22:40
% Zakończono 23:03

% Nie było złe. Najtrudniejsze uważam było zrobienie predykatu ile_pod_rzad, musiałem się trochę zastanowić
% A reszta bardzo schematyczna, tylko jak zwykle, głupie pomyłki są przyczyną zmarnowanego czasu ;)

konwersja_na_binarny(N, [N]) :- N < 2, !.
konwersja_na_binarny(N, L) :- M is mod(N, 2), NN is div(N, 2), konwersja_na_binarny(NN, LL), append(LL, [M], L).

lista__konwersja_na_binarny([], []) :- !.
lista__konwersja_na_binarny([H1 | T1], [H2 | T2]) :- konwersja_na_binarny(H1, H2), lista__konwersja_na_binarny(T1, T2).

ile_pod_rzad([_], [1]) :- !.
ile_pod_rzad([H1, H1 | T1], [N | T2]) :- !, ile_pod_rzad([H1 | T1], [NN | T2]), N is NN + 1.
ile_pod_rzad([H1, H2 | T1], [1 | T2]) :- !, ile_pod_rzad([H2 | T1], T2).

lista__ile_pod_rzad([], []) :- !.
lista__ile_pod_rzad([H1 | T1], [H2 | T2]) :- ile_pod_rzad(H1, H2), lista__ile_pod_rzad(T1, T2).

cyfry_na_liczbe([N], N) :- N < 10, !.
cyfry_na_liczbe(Lista, N) :- append(Reszta, [Ostatnia], Lista), !, cyfry_na_liczbe(Reszta, NN), N is 10 * NN + Ostatnia.

lista__cyfry_na_liczbe([], []) :- !.
lista__cyfry_na_liczbe([H1 | T1], [H2 | T2]) :- cyfry_na_liczbe(H1, H2), lista__cyfry_na_liczbe(T1, T2).



partition([_, _], [], [], []). :- !.

partition([PivotKey, _], [[Key, Value] | Tail], [[Key, Value] | Lewa], Prawa) :-
	Key =< PivotKey,
	!,
	partition([PivotKey, _], Tail, Lewa, Prawa)
.

partition([PivotKey, _], [[Key, Value] | Tail], Lewa, [[Key, Value] | Prawa]) :-
	partition([PivotKey, _], Tail, Lewa, Prawa)
.

quicksort([], []) :- !.
quicksort([H | T], Sorted) :-
	partition(H, T, Lewa, Prawa),
	quicksort(Lewa, LewaPosortowana),
	quicksort(Prawa, PrawaPosortowana),
	append(LewaPosortowana, [H], LewaOrazPivot),
	append(LewaOrazPivot, Prawa, Sorted)
.


scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :- scal(T1, T2, T).

zadanie(Lista, Wynik) :-
	lista__konwersja_na_binarny(Lista, Lista2),
	lista__ile_pod_rzad(Lista2, Lista3),
	lista__cyfry_na_liczbe(Lista3, Lista4),
	scal(Lista4, Lista, Lista5),
	quicksort(Lista5, Lista6),
	scal(_, Wynik, Lista6)
.
