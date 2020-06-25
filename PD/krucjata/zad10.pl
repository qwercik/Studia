% Rozpoczęto 17:01
% Zakończono 17:15

% Całkiem proste i przyjemne zadanko
% Nie wymagało wielkiego kombinowania, wystarczy znać na blachę ten standardowy zestaw operacji (sortowanie, konwersja między systemami)
% Zrobiłbym szybciej, ale musiałem się trochę pomęczyć szukając błędów ;)
% Najtrudniejszym elementem było chyba zrobienie usuwania powtórzeń
% Ale to też jest coś co często się może zdarzyć na zaliczeniu, więc warto to też dobrze ogarnąć

konwersja_na_binarny(N, [N]) :- N < 2, !.
konwersja_na_binarny(N, Lista) :-
	M is mod(N, 2),
	R is div(N, 2),
	konwersja_na_binarny(R, LL),
	append(LL, [M], Lista)
.

konwersja_z_binarnego([N], N) :- N < 2, !.
konwersja_z_binarnego(Lista, N) :-
	append(Reszta, [Ostatnia], Lista),
	konwersja_z_binarnego(Reszta, NN),
	N is NN * 2 + Ostatnia
.

usuwanie_powtorzen([], []) :- !.
usuwanie_powtorzen([H, H | T1], T2) :-
	usuwanie_powtorzen([H | T1], T2),
	!
.
usuwanie_powtorzen([X | T1], [X | T2]) :-
	usuwanie_powtorzen(T1, T2)
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

quicksort([], []) :- !.
quicksort([H | T], S) :-
	partition(H, T, L, P),
	quicksort(L, LS),
	quicksort(P, PS),
	append(LS, [H], LSH),
	append(LSH, PS, S)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :- scal(T1, T2, T).

lista__konwersja_na_binarny([], []) :- !.
lista__konwersja_na_binarny([H1 | T1], [H2 | T2]) :-
	konwersja_na_binarny(H1, H2),
	lista__konwersja_na_binarny(T1, T2)
.

lista__konwersja_z_binarnego([], []) :- !.
lista__konwersja_z_binarnego([H1 | T1], [H2 | T2]) :-
	konwersja_z_binarnego(H1, H2),
	lista__konwersja_z_binarnego(T1, T2)
.

lista__usuwanie_powtorzen([], []) :- !.
lista__usuwanie_powtorzen([H1 | T1], [H2 | T2]) :-
	usuwanie_powtorzen(H1, H2),
	lista__usuwanie_powtorzen(T1, T2)
.


zadanie(Lista, Wynik) :-
	lista__konwersja_na_binarny(Lista, Lista1),
	lista__usuwanie_powtorzen(Lista1, Lista2),
	lista__konwersja_z_binarnego(Lista2, Lista3),
	scal(Lista3, Lista, Lista4),
	quicksort(Lista4, Lista5),
	scal(_, Wynik, Lista5)
.
