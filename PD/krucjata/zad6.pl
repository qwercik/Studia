% Rozpoczęto 13:51
% Zakończono 14:25

% No... trochę długo mi to zajęło. Główny problem był taki, że nie zrozumiałem polecenia i dopiero po jakimś czasie je załapałem ;)
% Ale później udało się to chyba zrobić. Najśmieszniejszy jest chyba predykat wstawiaj. Jest prosty, ale można było dostać od niego bólu głowy

alfabet([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]). % w czy v jest pierwsze?

idx(X, N) :- alfabet(Alfabet), idx(X, Alfabet, N).
idx(X, [X | T], 0) :- !.
idx(X, [H | T], N) :- idx(X, T, NN), N is NN + 1.

odl(S1, S2, D) :- idx(S1, N1), idx(S2, N2), D is abs(N1 - N2).


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
quicksort([H | T], Sorted) :-
	partition(H, T, Left, Right),
	quicksort(Left, LeftSorted),
	quicksort(Right, RightSorted),
	append(LeftSorted, [H], LeftSortedWithH),
	append(LeftSortedWithH, RightSorted, Sorted)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :-
	scal(T1, T2, T)
.

najblizsza(_, [X], X) :- !.
najblizsza(Litera, [H | T], X1) :-
	najblizsza(Litera, T, X1),
	odl(Litera, H, D1),
	odl(Litera, X1, D2),
	D2 =< D1,
	!
.
najblizsza(Litera, [H | T], H).


inicjalizuj_liste_o_takim_samym_rozmiarze([], []) :- !.
inicjalizuj_liste_o_takim_samym_rozmiarze([_ | T1], [[] | T2]) :-
	inicjalizuj_liste_o_takim_samym_rozmiarze(T1, T2)
.


alfagrup(Lista, DrugaLista, Wynik) :-
	inicjalizuj_liste_o_takim_samym_rozmiarze(Lista, ListaNaWyniki),
	alfagrup(Lista, DrugaLista, ListaNaWyniki, Wynik)
.

alfagrup(_, [], W, W) :- !.
alfagrup(Lista, [H | T], WynikiPoprzednie, WynikiNastepne) :-
	najblizsza(H, Lista, Najblizsza),
	wstawiaj(Najblizsza, Lista, H, WynikiPoprzednie, WynikiPosrednie),
	alfagrup(Lista, T, WynikiPosrednie, WynikiNastepne)
.


wstawiaj(X, [], Y, W, W) :- !.
wstawiaj(X, [X | T1], Y, [H | T2], [HH | T2]) :-
	append(H, [Y], HH),
	!
.
wstawiaj(X, [_ | T1], Y, [H | T2], [H | T3]) :-
	wstawiaj(X, T1, Y, T2, T3)
.




% odleglosci_od_litery(Litera, [], []) :- !.
% odleglosci_od_litery(Litera, [H1 | T1], [H2 | T2]) :-
% 	odl(Litera, H1, H2),
% 	odleglosci_od_litery(Litera, T1, T2)
% .
% 
% sortuj_liste_wg_litery(Litera, Lista, Wynik) :- 
% 	odleglosci_od_litery(Litera, Lista, Lista2),
% 	scal(Lista2, Litera, Scalone),
% 	quicksort(Scalone, Posortowane),
% 	scak(_, Wynik, Posortowane)
% .
% 
% alfagrup([], _, []) :- !.
% alfagrup([H1 | T1], Lista, [H2 | T2]) :-
% 	sortuj_liste_wg_litery(H1, Lista, H2),
% 	alfagrup(T1, Lista, T2)
% .


