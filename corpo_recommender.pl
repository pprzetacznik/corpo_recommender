:- module(corpo_recommender,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2]).


jest_to(tester_manualny) :-
  jest(tester),
  jest(eksperymentator),
  pozytywne(jest, cierpliwy).

jest_to(tester_automatyczny) :-
  jest(tester),
  pozytywne(zna, programowanie),
  pozytywne(zna, metodyki_wytwarzania_oprogramowania).

jest_to(programista) :-
  jest(umyslem_scislym),
  pozytywne(zna, programowanie),
  pozytywne(zna, metodyki_wytwarzania_oprogramowania),
  pozytywne(jest, schematyczny).

jest_to(project_menadzer) :-
  jest(lider),
  jest(negocjator),
  pozytywne(zna, metodyki_wytwarzania_oprogramowania).

jest_to(architekt) :-
  jest_to(programista),
  jest_to(tester),
  pozytywne(ma, duzy_staz).

jest_to(frontend) :-
  jest(esteta),
  jest(wizjoner),
  pozytywne(jest, cierpliwy),
  pozytywne(sie, angazuje).

jest_to(backend) :-
  jest(umyslem_scislym),
  pozytywne(jest, dokladny),
  pozytywne(zna, programowanie).

jest_to(producent) :-
  jest(wizjoner),
  jest(negocjator),
  not(jest(ryzykant)),
  pozytywne(ma, duzy_staz).

jest_to(pr) :-
  jest(wizjoner),
  jest(esteta),
  pozytywne(zna, praca_w_grupie),
  pozytywne(dobrze, negocjuje),
  pozytywne(jest, asertywny).

jest_to(administrator) :-
  pozytywne(zna, sieci).

jest_to(analityk) :-
  jest(eksperymentator),
  pozytywne(zna, statystyka).

jest_to(badacz) :-
  jest(ryzykant),
  jest(eksperymentator),
  pozytywne(zna, programowanie),
  pozytywne(zna, statystyka).

jest_to(hr) :-
  jest(wizjoner),
  jest(esteta),
  pozytywne(dobrze, negocjuje),
  pozytywne(jest, asertywny).

jest_to(grafik) :-
  jest(esteta),
  pozytywne(zna,photoshop).



jest(tester) :-
  jest(umyslem_scislym),
  pozytywne(jest, dokladny),
  pozytywne(zna, testowanie).

jest(negocjator) :-
  pozytywne(jest, asertywny),
  pozytywne(jest, odporny_na_stres),
  pozytywne(zna, praca_w_grupie),
  pozytywne(dobrze, negocjuje),
  pozytywne(lubi, samorozwoj).

jest(esteta) :-
  pozytywne(projektuje, ladne_rzeczy),
  pozytywne(jest, dokladny).

jest(ryzykant) :-
  pozytywne(lubi, ryzyko),
  negatywne(patrzy, przyszlosciowo).

jest(eksperymentator) :-
  pozytywne(lubi, ryzyko),
  pozytywne(patrzy, przyszlosciowo).

jest(lider) :-
  jest(wizjoner),
  pozytywne(sie, angazuje),
  pozytywne(jest, asertywny).

jest(elastyczny) :-
  negatywne(lubi, sztywne_godziny_pracy),
  negatywne(jest, schematyczny).

jest(wizjoner) :-
  pozytywne(patrzy, przyszlosciowo),
  pozytywne(lubi, eksperymentowac),
  negatywne(jest, schematyczny).

jest(umyslem_scislym) :-
  pozytywne(umie, matematyke);
  pozytywne(mysli, logicznie).


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
