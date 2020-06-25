% Start 21:29
% Koniec (po kilkuminutowym debugowaniu) 21:51
% Komentarz: poza tym że kilka minut spędziłem na bezsensownym debugowaniu, to nawet przyjemne zadanko

rozbij(N, [N]) :- N < 10, !.
rozbij(N, L) :- M is mod(N, 10), N1 is div(N, 10), rozbij(N1, T), append(T, [M], L).

napraw_monotonicznosc([], []) :- !.
napraw_monotonicznosc([H], [H]) :- !.
napraw_monotonicznosc([H1, H2 | T1], [H1, H2 | T2]) :- H1 < H2, !, napraw_monotonicznosc([H2 | T1], [H2 | T2]).
napraw_monotonicznosc([H1, H2 | T1], [H1 | T2]) :- napraw_monotonicznosc([H1 | T1], [H1 | T2]).

polacz([N], N) :- N < 10, !.
polacz(Lista, N) :- append(Reszta, [Ostatnia], Lista), !, polacz(Reszta, NN), N is NN * 10 + Ostatnia.


quicksort([], []) :- !.
quicksort([H | T], Posortowane) :-
	partition(H, T, Lewe, Prawe),
	quicksort(Lewe, LewePosortowane),
	quicksort(Prawe, PrawePosortowane),
	append(LewePosortowane, [H], LewePivot),
	append(LewePivot, PrawePosortowane, Posortowane)
.

partition([_, _], [], [], []) :- !.
partition([PivotKey, _], [[Klucz, Wartosc] | Ogon], [[Klucz, Wartosc] | Lewe], Prawe) :-
	Klucz < PivotKey,
	!,
	partition([PivotKey, _], Ogon, Lewe, Prawe)
.
partition([PivotKey, _], [[Klucz, Wartosc] | Ogon], Lewe, [[Klucz, Wartosc] | Prawe]) :-
	partition([PivotKey, _], Ogon, Lewe, Prawe)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :- scal(T1, T2, T).

rozbij_liste([], []) :- !.
rozbij_liste([H1 | T1], [H2 | T2]) :- rozbij(H1, H2), rozbij_liste(T1, T2).

napraw_monotonicznosc_w_liscie([], []) :- !.
napraw_monotonicznosc_w_liscie([H1 | T1], [H2 | T2]) :- napraw_monotonicznosc(H1, H2), napraw_monotonicznosc_w_liscie(T1, T2).

polacz_w_liscie([], []) :- !.
polacz_w_liscie([H1 | T1], [H2 | T2]) :- polacz(H1, H2), polacz_w_liscie(T1, T2).

zadanie(Lista, Wynik) :-
	rozbij_liste(Lista, Lista2),
	napraw_monotonicznosc_w_liscie(Lista2, Lista3),
	polacz_w_liscie(Lista3, Lista4),
	scal(Lista4, Lista, Scalona),
	quicksort(Scalona, Posortowana),
	scal(_, Wynik, Posortowana)
.
