:- module(corpo_recommender,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2, xjest/1, xjest_to/1, xwhy/2, xhow/4]).

przygotuj :-
  assertz(xpozytywne('')),
  assertz(xnegatywne('')),
  assertz(xjest('')),
  assertz(xjest_to('')),
  assertz(xwhy('','')),
  assertz(xhow('','','','')).

kjest_to(X) :-
  jest_to(X),
  (xjest_to(X);
  (assertz(xjest_to(X)),
  assertz(xwhy('jest_to', X)))).

jest_to(tester_manualny) :-
  kjest(tester),
  kjest(eksperymentator),
  pozytywne(jest, cierpliwy).

jest_to(tester_automatyczny) :-
  kjest(tester),
  pozytywne(zna, programowanie),
  pozytywne(zna, metodyki_wytwarzania_oprogramowania).

jest_to(programista) :-
  kjest(umyslem_scislym),
  pozytywne(zna, programowanie),
  pozytywne(zna, metodyki_wytwarzania_oprogramowania),
  pozytywne(jest, schematyczny).

jest_to(project_menadzer) :-
  kjest(lider),
  kjest(negocjator),
  pozytywne(zna, metodyki_wytwarzania_oprogramowania).

jest_to(architekt) :-
  kjest_to(programista),
  kjest(tester),
  pozytywne(ma, duzy_staz).

jest_to(frontend) :-
  kjest(esteta),
  kjest(wizjoner),
  pozytywne(jest, cierpliwy),
  pozytywne(sie, angazuje).

jest_to(backend) :-
  kjest(umyslem_scislym),
  pozytywne(jest, dokladny),
  pozytywne(zna, programowanie).

jest_to(producent) :-
  kjest(wizjoner),
  kjest(negocjator),
  not(jest(ryzykant)),
  pozytywne(ma, duzy_staz).

jest_to(pr) :-
  kjest(wizjoner),
  kjest(esteta),
  pozytywne(zna, praca_w_grupie),
  pozytywne(dobrze, negocjuje),
  pozytywne(jest, asertywny).

jest_to(administrator) :-
  pozytywne(zna, sieci).

jest_to(analityk) :-
  kjest(eksperymentator),
  pozytywne(zna, statystyka).

jest_to(badacz) :-
  kjest(ryzykant),
  kjest(eksperymentator),
  pozytywne(zna, programowanie),
  pozytywne(zna, statystyka).

jest_to(hr) :-
  kjest(wizjoner),
  kjest(esteta),
  pozytywne(dobrze, negocjuje),
  pozytywne(jest, asertywny).

jest_to(grafik) :-
  kjest(esteta),
  pozytywne(zna,photoshop).



kjest(X) :-
  assertz(xwhy('jest', X)),
  jest(X),
  (xjest(X);
  assertz(xjest(X))).

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

pytaj(X, Y, K) :-
  !, write(X), write(' nasz_pracownik '), write(Y), write(' ? (t/n)\n'),
  readln([Replay]),

  (pamietaj(X, Y, Replay),
  odpowiedz(Replay, K);

  (odpowiedz(Replay, what),
  pytaj(X, Y, K));

  (odpowiedz(Replay, how),
  pytaj(X, Y, K));

  (odpowiedz(Replay, why),
  pytaj(X, Y, K));

  (odpowiedz(Replay, help),
  pytaj(X, Y, K))).

odpowiedz(Replay, tak) :-
  sub_string(Replay, 0, _, _, 't').

odpowiedz(Replay, nie) :-
  sub_string(Replay, 0, _, _, 'n').

odpowiedz(Replay, what) :-
  sub_string(Replay, 0, _, _, 'what'),
  podaj_what.

odpowiedz(Replay, why) :-
  sub_string(Replay, 0, _, _, 'why'),
  podaj_why.

odpowiedz(Replay, how) :-
  sub_string(Replay, 0, _, _, 'how'),
  podaj_how.

odpowiedz(Replay, help) :-
  sub_string(Replay, 0, _, _, 'help'),
  help.

help :-
  write('help - pomoc\n'),
  write('what - lista dotychczas ustalonych faktow (symptomy, fakty posrednie, hipoteza)\n'),
  write('how - lista what poszerzona o sposob w jaki uzyskano dany fakt (odpowiedz na symptom, reguly)\n'),
  write('why - dlaczego system pyta o dany symptom (stos regul przetwarzanych, ktore wygenerowaly pytanie)\n').

pamietaj(X, Y, Replay) :-
  odpowiedz(Replay, tak),
  assertz(xpozytywne(Y)),
  assertz(xhow(X, Y, 'tak')).

pamietaj(X, Y, Replay) :-
  odpowiedz(Replay, nie),
  assertz(xnegatywne(Y)),
  assertz(xhow(X, Y, 'nie')).

podaj_what :-
  write('WHAT:\n'),
  write('Hipotezy:\n'),
  setof(K1, xjest_to(K1), L1),
  drukuj_bez_glowy(L1),

  write('\nFakty posrednie:\n'),
  setof(K2, xjest(K2), L2),
  drukuj_bez_glowy(L2),

  write('\nSymptomy na tak:\n'),
  setof(K3, xpozytywne(K3), L3),
  drukuj_bez_glowy(L3),

  write('\nSymptomy na nie:\n'),
  setof(K4, xnegatywne(K4), L4),
  drukuj_bez_glowy(L4),
  write('KONIEC WHAT\n').

podaj_why :-
  write('WHY:\n'),
  write('Stos zapytan:\n'),
  bagof([K00, K01], xwhy(K00,K01), L00),
  drukuj(L00),
  write('KONIEC WHY\n').

podaj_how :-
  podaj_what,
  write('HOW:\n'),
  write('Skad sie wziely fakty posrednie:\n'),
  setof([Fakt1, Fakt2, Fakt3, Fakt4], (xhow(Fakt1, Fakt2, Fakt3, Fakt4), xjest(Fakt1)), Bufor),
  drukuj(Bufor),
  write('\n\nSkad sie wziely hipotezy:\n'),
  setof([H1, H2, H3, H4], (xhow(H1, H2, H3, H4), xjest_to(H1)), B2),
  drukuj(B2),
  write('KONIEC HOW\n').

resetuj_stan :-
  write('\n\nNacisnij enter aby zakonczyc\n'),
  retractall(xpozytywne(_, _)),
  retractall(xnegatywne(_, _)),
  retractall(xwhy(_, _)),
  retractall(xhow(_, _, _, _)),
  readln(_).

drukuj_bez_glowy([_|T]) :-
  drukuj([T]).

drukuj([]).
drukuj([X|Y]) :-
  write('- '), write(X), write(',\n'), drukuj(Y).

wykonaj :-
  przygotuj,
  % setof(A, kjest_to(A), B),
  % setof(Y, kjest(Y), Z),
  % write('Twoj pracownik jest:\n'), drukuj(Z), nl,
  % write('Twoj pracownik moze zostac:\n'), drukuj(B), nl,
  jest_to(X), !,
  write('Twoj pracownik moze byc '), write(X), nl,
  resetuj_stan.

wykonaj :-
  write('\nNie jestem w stanie odgadnac, '),
  write('gdzie moglby pracowac Twoj pracownik.\n\n'),
  resetuj_stan.
