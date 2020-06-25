% Rozpoczęto 15:01
% Zakończono 15:19

% Nie wiem czy jest zrobione poprawnie, ale wydaje się proste
% Tylko dziwne błędy znowu dały o sobie znać ;)

min([X], X) :- !.
min([H | T], M) :-
	min(T, M),
	M =< H,
	!
.
min([H | _], H).

max([X], X) :- !.
max([H | T], M) :-
	max(T, M),
	M >= H,
	!
.
max([H | _], H).

suma_i_liczba_w_przedziale(P, K, [], 0, 0) :- !.
suma_i_liczba_w_przedziale(P, K, [X | T], S, N) :-
	P < X,
	X < K,
	!,
	suma_i_liczba_w_przedziale(P, K, T, SS, NN),
	S is SS + X,
	N is NN + 1
.
suma_i_liczba_w_przedziale(P, K, [_ | T], S, N) :-
	suma_i_liczba_w_przedziale(P, K, T, S, N)
.

srednia_pomiedzy_min_i_max(Lista, S) :-
	min(Lista, P),
	max(Lista, K),
	suma_i_liczba_w_przedziale(P, K, Lista, Suma, Liczba),
	S is Suma / Liczba
.

lista__srednia_pomiedzy_min_i_max([], []).
lista__srednia_pomiedzy_min_i_max([H1 | T1], [H2 | T2]) :-
	srednia_pomiedzy_min_i_max(H1, H2),
	lista__srednia_pomiedzy_min_i_max(T1, T2)
.

partition([_, _], [], [], []) :- !.
partition([PivotKey, _], [[Key, Value] | Tail], [[Key, Value] | Left], Right) :- 
	Key < PivotKey,
	!,
	partition([PivotKey, _], Tail, Left, Right)
.
partition([PivotKey, _], [[Key, Value] | Tail], Left, [[Key, Value] | Right]) :-
	partition([PivotKey, _], Tail, Left, Right)
.

quicksort([], []) :- !.
quicksort([H | T], S) :-
	partition(H, T, L, R),
	quicksort(L, LS),
	quicksort(R, RS),
	append(LS, [H], LSH),
	append(LSH, RS, S)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :-
	scal(T1, T2, T)
.

zadanie(Lista, Wynik) :-
	lista__srednia_pomiedzy_min_i_max(Lista, Lista1),
	scal(Lista1, Lista, Lista2),
	quicksort(Lista2, Lista3),
	scal(_, Wynik, Lista3)
.
