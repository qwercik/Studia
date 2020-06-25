% Rozpoczęto 14:38
% Zakończono 14:55

% Wydawało mi się na początku ciężkie, ale w sumie było bardzo przyjemne ;)
% Doszły kolejne ciekawe predykaty do nauczenia się: unikalne oraz czynniki_pierwsze
% A reszta to już taki standard ;)

czynniki_pierwsze(N, Lista) :- czynniki_pierwsze(N, 2, Lista).

czynniki_pierwsze(N, D, []) :- D > N, !.
czynniki_pierwsze(N, D, [D | Lista]) :-
	mod(N, D) =:= 0,
	!,
	NN is div(N, D),
	czynniki_pierwsze(NN, D, Lista)
.
czynniki_pierwsze(N, D, Lista) :-
	DD is D + 1,
	czynniki_pierwsze(N, DD, Lista)
.

unikalne([], []) :- !.
unikalne([H1 | T1], T2) :-
	member(H1, T1),
	!,
	unikalne(T1, T2)
.
unikalne([H1 | T1], [H1 | T2]) :-
	unikalne(T1, T2)
.

lista__czynniki_pierwsze([], []) :- !.
lista__czynniki_pierwsze([H1 | T1], [H2 | T2]) :-
	czynniki_pierwsze(H1, H2),
	lista__czynniki_pierwsze(T1, T2)
.

lista__unikalne([], []) :- !.
lista__unikalne([H1 | T1], [H2 | T2]) :-
	unikalne(H1, H2),
	lista__unikalne(T1, T2)
.

lista__length([], []) :- !.
lista__length([H1 | T1], [H2 | T2]) :-
	length(H1, H2),
	lista__length(T1, T2)
.

scal([], [], []) :- !.
scal([H1 | T1], [H2 | T2], [[H1, H2] | T]) :-
	scal(T1, T2, T)
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
quicksort([H | T], Sorted) :-
	partition(H, T, Left, Right),
	quicksort(Left, LeftSorted),
	quicksort(Right, RightSorted),
	append(LeftSorted, [H], LeftSortedHead),
	append(LeftSortedHead, RightSorted, Sorted)
.

zadanie(Lista, Wynik) :-
	lista__czynniki_pierwsze(Lista, CzynnikiPierwsze),
	lista__unikalne(CzynnikiPierwsze, UnikalneCzynnikiPierwsze),
	lista__length(UnikalneCzynnikiPierwsze, IloscUnikalnychCzynnikowPierwszych),
	scal(IloscUnikalnychCzynnikowPierwszych, Lista, Scalone),
	quicksort(Scalone, Posortowane),
	scal(_, Wynik, Posortowane)
.
