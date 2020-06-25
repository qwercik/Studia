% Rozpoczęto 13:15
% Zakończono 13:31

% Całkiem przyjemne i proste zadanko, chyba najprostsze z tych do tej pory
% Ale może dlatego, że poszukiwanie minimalnej odległości było już w którymś z poprzednich zadań i po prostu wykorzystałem ten sam pomysł

srodek_przedzialu([X, Y], S) :- S is (X + Y) / 2.

lista__srodek_przedzialu([], []) :- !.
lista__srodek_przedzialu([H1 | T1], [H2 | T2]) :- srodek_przedzialu(H1, H2), lista__srodek_przedzialu(T1, T2).

min_odleglosc(Element, [X], D) :- D is abs(Element - X), !.
min_odleglosc(Element, [H | T], D1) :- min_odleglosc(Element, T, D1), min_odleglosc(Element, [H], D2), D1 < D2, !.
min_odleglosc(Element, [H | T], D) :- min_odleglosc(Element, [H], D).

lista__min_odleglosc(Lista, Wynik) :- lista__min_odleglosc__pomocniczy([], Lista, Wynik).
	
lista__min_odleglosc__pomocniczy(_, [], []) :- !.
lista__min_odleglosc__pomocniczy(Lista, [H1 | T1], [H2 | T2]) :-
	append(Lista, T1, ObecnaLista), % W liście nie może być obecnego elementu
	min_odleglosc(H1, ObecnaLista, H2),
	lista__min_odleglosc__pomocniczy([H1 | Lista], T1, T2)
.

zadanie(Lista, Wynik) :-
	lista__srodek_przedzialu(Lista, Lista2),
	lista__min_odleglosc(Lista2, Lista3),
	scal(Lista3, Lista, Lista4),
	quicksort(Lista4, Lista5),
	scal(_, Wynik, Lista5)
.

partition([_, _], [], [], []) :- !.
partition([PivotKey, _], [[Key, Value] | Tail], [[Key, Value] | Lewo], Prawo) :-
	Key =< PivotKey,
	!,
	partition([PivotKey, _], Tail, Lewo, Prawo)
.
partition([PivotKey, _], [[Key, Value] | Tail], Lewo, [[Key, Value] | Prawo]) :-
	partition([PivotKey, _], Tail, Lewo, Prawo)
.

quicksort([], []) :- !.
quicksort([H | T], Sorted) :-
	partition(H, T, Lewo, Prawo),
	quicksort(Lewo, LewoPosortowane),
	quicksort(Prawo, PrawoPosortowane),
	append(Lewo, [H], LewoH),
	append(LewoH, PrawoPosortowane, Sorted)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :- scal(T1, T2, T).


