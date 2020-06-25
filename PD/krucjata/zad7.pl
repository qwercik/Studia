% Rozpoczęto 14:45
% Zakończono 15:02

% Zadanko zrobione na szybko, całkiem przyjemne
% problem jest taki, że zastosowana metoda nie jest poprawna matematycznie
% ale co poradzić :(


kwadrat_odleglosci([P1x, P1y], [P2x, P2y], Wynik) :-
	Wynik is (P1x - P2x)^2 + (P1y - P2y)^2
.

najbardziej_oddalone_punkty([P1, P2], P1, P2) :- !.
najbardziej_oddalone_punkty([H | T], P1, P2) :-
	punkt_najbardziej_oddalony(H, T, P),
	najbardziej_oddalone_punkty(T, P1, P2),
	kwadrat_odleglosci(H, P, D),
	kwadrat_odleglosci(P1, P2, DD),
	D < DD,
	!
.
najbardziej_oddalone_punkty([H | T], H, P) :-
	punkt_najbardziej_oddalony(H, T, P)
.

punkt_najbardziej_oddalony(Punkt, [InnyPunkt], InnyPunkt).
punkt_najbardziej_oddalony(Punkt, [InnyPunkt | Tail], NajbardziejOddalony) :-
	punkt_najbardziej_oddalony(Punkt, Tail, NajbardziejOddalony),
	kwadrat_odleglosci(Punkt, NajbardziejOddalony, D1),
	kwadrat_odleglosci(Punkt, InnyPunkt, D2),
	D1 > D2,
	!
.
punkt_najbardziej_oddalony(Punkt, [InnyPunkt | _], InnyPunkt).

punkt_najmniej_oddalony(Punkt, [InnyPunkt], InnyPunkt).
punkt_najmniej_oddalony(Punkt, [InnyPunkt | Tail], NajmniejOddalony) :-
	punkt_najmniej_oddalony(Punkt, Tail, NajmniejOddalony),
	kwadrat_odleglosci(Punkt, InnyPunkt, D1),
	kwadrat_odleglosci(Punkt, NajmniejOddalony, D2),
	D2 < D1,
	!
.
punkt_najmniej_oddalony(Punkt, [InnyPunkt | _], InnyPunkt).


srodek_odcinka([P1x, P1y], [P2x, P2y], [Sx, Sy]) :-
	Sx is (P1x + P2x) / 2,
	Sy is (P1y + P2y) / 2
.

zadanie(Lista, Wynik) :-
	najbardziej_oddalone_punkty(Lista, P1, P2),
	write(P1),
	write('->'),
	write(P2),
	nl,
	srodek_odcinka(P1, P2, S),
	write(S),
	punkt_najmniej_oddalony(S, Lista, Wynik)
.
