dot_product([], [], 0).
dot_product([H1 | T1], [H2 | T2], P) :-
	dot_product(T1, T2, P1),
	P is P1 + H1 * H2
.

list_nth([H | _], 0, H).
list_nth([_ | T], N, H) :-
	list_nth(T, N1, H),
	N is N1 + 1
.

count_rows(M, N) :- length(M, N).
count_columns([H | _], N) :- length(H, N).

nth_row(M, N, R) :- list_nth(M, N, R).

nth_column([], _, []).
nth_column([H1 | T1], N, [H2 | T2]) :-
	list_nth(H1, N, H2),
	nth_column(T1, N, T2)
.

matrix_product_generator(M1, M2, P) :-
	nth_row(M1, _, R),
	nth_column(M2, _, C),
	dot_product(R, C, P)
.

matrix_product_list(M1, M2, L) :-
	bagof(P, matrix_product_generator(M1, M2, P), L)
.

matrix_from_list(L, R, [L]) :- length(L, R).
matrix_from_list(L, R, [H | M]) :-
	length(L, D),
	D > R,
	append(H, L1, L),
	length(H, R),
	matrix_from_list(L1, R, M)
.

matrix_product(M1, M2, P) :-
	matrix_product_list(M1, M2, L),
	count_rows(M1, R),
	matrix_from_list(L, R, P)
.

