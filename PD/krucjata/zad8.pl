% Rozpoczęto 15:51
% Zakończono 16:07

% Przyjemne zadanie, ale poszło łatwiej bo już je kiedyś robiłem ;)
% Trochę może skomplikowałem operacje z tym iloczynem skalarnym, ale nie chciałem niczego pierwiastkować
% Aby uniknąć potencjalnych problemów z błędem zaokrąglenia

ile_trojkatow([], 0) :- !.
ile_trojkatow([H | T], N) :-
	ile_trojkatow_1(H, T, N1),
	ile_trojkatow(T, N2),
	N is N1 + N2
.

ile_trojkatow_1(_, [], 0) :- !.
ile_trojkatow_1(X, [H | T], N) :-
	ile_trojkatow_2(X, H, T, N1),
	ile_trojkatow_1(X, T, N2),
	N is N1 + N2
.

ile_trojkatow_2(_, _, [], 0) :- !.
ile_trojkatow_2(X, Y, [H | T], N) :-
	ile_trojkatow_3(X, Y, H, N1),
	ile_trojkatow_2(X, Y, T, N2),
	N is N1 + N2
.

% Jeżeli punkty się pokrywają, to się nie da utworzyć trójkąta
ile_trojkatow_3(X, X, _, 0) :- !.
ile_trojkatow_3(X, _, X, 0) :- !.
ile_trojkatow_3(_, X, X, 0) :- !.

% Jeżeli punkty są współliniowe, to również się nie da
% Wspóliniowość sprawdzam prowadząc dwa wektory z jednego wierzchołka do pozostałych wierzchołków
% Następnie liczę iloczyn skalarny tych wektorów i dzielę go przez iloczyn modułów tych wektorów
% Jeżeli wyjdzie 1 lub -1 to są to wektory równoległe, a więc nie da się utworzyć takiego trójkąta

ile_trojkatow_3(X, Y, Z, 0) :-
	wektor(X, Y, V1),
	wektor(X, Z, V2),
	kwadrat_cosinusa_kata_pomiedzy_wektorami(V1, V2, 1),
	!
.

% W każdym innym przypadku da sie utworzyć trójkąt
ile_trojkatow_3(_, _, _, 1).

wektor([X1, Y1], [X2, Y2], [VX, VY]) :-
	VX is X2 - X1,
	VY is Y2 - Y1
.

iloczyn_skalarny([X1, Y1], [X2, Y2], R) :-
	R is X1 * X2 + Y1 * Y2
.

kwadrat_modulu_wektora([X, Y], M) :-
	M is X^2 + Y^2
.

kwadrat_cosinusa_kata_pomiedzy_wektorami(V1, V2, C) :-
	iloczyn_skalarny(V1, V2, R),
	R2 is R^2,
	kwadrat_modulu_wektora(V1, M1),
	kwadrat_modulu_wektora(V2, M2),
	M is M1 * M2,
	C is R2 / M
.

% Predykat tylko po to, żeby było wiadomo gdzie "zaczyna się" zadanie
zadanie(X, Y) :- ile_trojkatow(X, Y).
