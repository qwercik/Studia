% Rozpoczęto 16:49
% Zakończono 16:59

% Rekord czasowy :D
% Bardzo łatwe i bardzo przyjemne zadanko, jeżeli ogarnęło się te podstawowe rzeczy typu konwersja, sortowanie i tak dalej

konwertuj_na_szesnastkowy(N, [N]) :- N < 16, !.
konwertuj_na_szesnastkowy(N, Lista) :- 
	M is mod(N, 16),
	L is div(N, 16),
	konwertuj_na_szesnastkowy(L, Reszta),
	append(Reszta, [M], Lista)
.

filtruj_cyfry([], []) :- !.
filtruj_cyfry([H1 | T1], [H1 | T2]) :-
	H1 < 10,
	!,
	filtruj_cyfry(T1, T2)
.
filtruj_cyfry([_ | T1], T2) :-
	filtruj_cyfry(T1, T2)
.

lista__konwertuj_na_szesnastkowy([], []) :- !.
lista__konwertuj_na_szesnastkowy([H1 | T1], [H2 | T2]) :-
	konwertuj_na_szesnastkowy(H1, H2),
	lista__konwertuj_na_szesnastkowy(T1, T2)
.

lista__filtruj_cyfry([], []) :- !.
lista__filtruj_cyfry([H1 | T1], [H2 | T2]) :-
	filtruj_cyfry(H1, H2),
	lista__filtruj_cyfry(T1, T2)
.

scal_cyfry_w_liczbe([N], N) :- N < 10, !.
scal_cyfry_w_liczbe(Liczby, N) :-
	append(Reszta, [Ostatnia], Liczby),
	scal_cyfry_w_liczbe(Reszta, NN),
	N is NN * 10 + Ostatnia
.

lista__scal_cyfry_w_liczbe([], []) :- !.
lista__scal_cyfry_w_liczbe([H1 | T1], [H2 | T2]) :-
	scal_cyfry_w_liczbe(H1, H2),
	lista__scal_cyfry_w_liczbe(T1, T2)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :-
	scal(T1, T2, T)
.

partition([_, _], [], [], []) :- !.
partition([PivotKlucz, _], [[Klucz, Wartosc] | Ogon], [[Klucz, Wartosc] | Lewo], Prawo) :-
	Klucz < PivotKlucz,
	!,
	partition([PivotKlucz, _], Ogon, Lewo, Prawo)
.

partition([PivotKlucz, _], [[Klucz, Wartosc] | Ogon], Lewo, [[Klucz, Wartosc] | Prawo]) :-
	partition([PivotKlucz, _], Ogon, Lewo, Prawo)
.


quicksort([], []).
quicksort([H | T], S) :-
	partition(H, T, L, R),
	quicksort(L, LS),
	quicksort(R, RS),
	append(LS, [H], LSH),
	append(LSH, RS, S)
.

zadanie(Lista, Wynik) :-
	lista__konwertuj_na_szesnastkowy(Lista, Lista2),
	lista__filtruj_cyfry(Lista2, Lista3),
	lista__scal_cyfry_w_liczbe(Lista3, Lista4),
	scal(Lista4, Lista, Lista5),
	quicksort(Lista5, Lista6),
	scal(_, Wynik, Lista6)
.
