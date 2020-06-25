% Początek 00:06
% Koniec 00:27

% Chyba najłatwiejsze z tych do tej pory (takie mam przynajmniej wrażenie ;-))
% Jak zwykle, część czasu została zmarnowana przez durne błędy typu [K | V] zamiast [K, V]
% Albo brak warunku początkowego

dzielniki_wlasciwe(N, N, []) :- !.
dzielniki_wlasciwe(N, S, [S | T]) :-
	S < N,
	mod(N, S) =:= 0,
	S1 is S + 1,
	dzielniki_wlasciwe(N, S1, T),
	!
.
dzielniki_wlasciwe(N, S, T) :-
	S < N,
	mod(N, S) =\= 0,
	S1 is S + 1,
	dzielniki_wlasciwe(N, S1, T)
.

dzielniki_wlasciwe(N, L) :- dzielniki_wlasciwe(N, 1, L).

dodaj_gdy_modulo2(_, [], 0) :- !.
dodaj_gdy_modulo2(Modulo, [H | T], N) :-
	mod(H, 2) =:= Modulo,
	!,
	dodaj_gdy_modulo2(Modulo, T, NN),
	N is NN + H
.
dodaj_gdy_modulo2(Modulo, [_ | T], N) :- dodaj_gdy_modulo2(Modulo, T, N).


przerob_liste([], []) :- !.
przerob_liste([H1 | T1], [H2 | T2]) :-
	Modulo is mod(H1, 2),
	dzielniki_wlasciwe(H1, Dzielniki),
	dodaj_gdy_modulo2(Modulo, Dzielniki, H2),
	przerob_liste(T1, T2)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :- scal(T1, T2, T).

partition([_, _], [], [], []) :- !.
partition([P, _], [[K, V] | Tail], [[K, V] | Lewo], Prawo) :- 
	K =< P,
	!,
	partition([P, _], Tail, Lewo, Prawo)
.
partition([P, _], [[K, V] | Tail], Lewo, [[K, V] | Prawo]) :- 
	partition([P, _], Tail, Lewo, Prawo)
.

quicksort([], []) :- !.
quicksort([H | T], S) :-
	partition(H, T, L, P),
	quicksort(L, LS),
	quicksort(P, PS),
	append(LS, [H], LSH),
	append(LSH, PS, S)
.

zadanie(Lista, Wynik) :-
	przerob_liste(Lista, Klucze),
	scal(Klucze, Lista, Scalona),
	quicksort(Scalona, Posortowana),
	scal(_, Wynik, Posortowana)
.
