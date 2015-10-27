:- module(corpo_recommender,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2]).


jest_to(tester) :-
  zna(programowanie),
  zna(testowanie),
  zna(metodyki_wytwarzania_oprogramowania),
  jest(dokladny).

jest_to(programista) :-
  zna(programowanie),
  zna(metodyki_wytwarzania_oprogramowania).

jest_to(project_menadzer) :-
  zna(metodyki_wytwarzania_oprogramowania),
  zna(praca_w_grupie),
  jest(negocjator),
  jest(wizjoner),
  jest(asertywny),
  jest(lider).

jest_to(architekt) :-
  jest_to(programista),
  jest_to(tester).

jest_to(pr) :-
  zna(praca_w_grupie),
  jest(negocjator),
  jest(wizjoner),
  jest(esteta),
  jest(asertywny).

jest_to(administrator) :-
  zna(sieci).

jest_to(analityk) :-
  zna(statystyka),
  jest(eksperymentator).

jest_to(badacz) :-
  zna(programowanie),
  zna(statystyka),
  jest(eksperymentator),
  jest(ryzykant).

jest_to(hr) :-
  jest(negocjator),
  jest(wizjoner),
  jest(esteta),
  jest(asertywny).

jest_to(grafik) :-
  zna(photoshop),
  jest(dokladny),
  jest(esteta).


zna(praca_w_grupie) :-
  pozytywne(zna, praca_w_grupie).

zna(programowanie) :-
  pozytywne(zna, programowanie).

zna(testowanie) :-
  pozytywne(zna, testowanie).

zna(metodyki_wytwarzania_oprogramowania) :-
  pozytywne(zna, metodyki_wytwarzania_oprogramowania).

zna(photoshop) :-
  pozytywne(zna, photoshop).

zna(statystyka) :-
  pozytywne(zna, statystyka).

zna(sieci) :-
  pozytywne(zna, sieci).

jest(asertywny) :-
  pozytywne(jest, asertywny).

jest(negocjator) :-
  pozytywne(dobrze, negocjuje).

jest(esteta) :-
  pozytywne(projektuje, ładne_rzeczy).

jest(dokladny) :-
  pozytywne(jest, dokładny).

jest(odporny_na_stres) :-
  pozytywne(jest, odporny_na_stres).

jest(ryzykant) :-
  pozytywne(lubi, ryzyko).

jest(eksperymentator) :-
  pozytywne(lubi, eksperymentowac).

jest(lider) :-
  jest(wizjoner),
  pozytywne(sie, angazuje).

jest(elastyczny) :-
  negatywne(lubi, sztywne_godziny_pracy).

jest(wizjoner) :-
  pozytywne(mysli, przyszlosciowo).


pozytywne(X, Y) :-
  xpozytywne(X, Y), !.

pozytywne(X, Y) :-
  not(xnegatywne(X, Y)),
  pytaj(X, Y, tak).

negatywne(X, Y) :-
  xnegatywne(X, Y), !.

negatywne(X, Y) :-
  not(xpozytywne(X, Y)),
  pytaj(X, Y, nie).

pytaj(X, Y, tak) :-
  !, write(X), write(' nasz_pracownik '), write(Y), write(' ? (t/n)\n'),
  readln([Replay]),
  pamietaj(X, Y, Replay),
  odpowiedz(Replay, tak).


pytaj(X, Y, nie) :-
  !, write(X), write(' nasz_pracownik '), write(Y), write(' ? (t/n)\n'),
  readln([Replay]),
  pamietaj(X, Y, Replay),
  odpowiedz(Replay, nie).

odpowiedz(Replay, tak):-
  sub_string(Replay, 0, _, _, 't').

odpowiedz(Replay, nie):-
  sub_string(Replay, 0, _, _, 'n').

pamietaj(X, Y, Replay) :-
  odpowiedz(Replay, tak),
  assertz(xpozytywne(X, Y)).

pamietaj(X, Y, Replay) :-
  odpowiedz(Replay, nie),
  assertz(xnegatywne(X, Y)).

wyczysc_fakty :-
  write('\n\nNacisnij enter aby zakonczyc\n'),
  retractall(xpozytywne(_, _)),
  retractall(xnegatywne(_, _)),
  readln(_).

wykonaj :-
  jest_to(X), !,
  write('Twoj pracownik moze byc '), write(X), nl,
  wyczysc_fakty.

wykonaj :-
  write('\nNie jestem w stanie odgadnac, '),
  write('gdzie moglby pracowac Twoj pracownik.\n\n'), wyczysc_fakty.
