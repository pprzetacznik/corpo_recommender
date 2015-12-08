:- module(corpo_recommender,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2, xjest/1, xjest_to/1, xwhy/3, xhow/5]).

przygotuj :-
  assertz(xpozytywne('', '')),
  assertz(xnegatywne('', '')),
  assertz(xjest('')),
  assertz(xjest_to('')),
  assertz(xwhy('','', '')),
  assertz(xhow('','','','','')).

kjest_to(X) :-
  jest_to(X),
  (xjest_to(X);
  (assertz(xjest_to(X)),
  assertz(xwhy('jest_to', X)))).

jest_to(tester_manualny) :-
  kjest(tester_manualny, tester),
  kjest(tester_manualny, eksperymentator),
  pozytywne(tester_manualny, jest, cierpliwy).

jest_to(tester_automatyczny) :-
  kjest(tester_automatyczny, tester),
  pozytywne(tester_automatyczny, zna, programowanie),
  pozytywne(tester_automatyczny, zna, metodyki_wytwarzania_oprogramowania).

jest_to(programista) :-
  kjest(programista, umyslem_scislym),
  pozytywne(programista, zna, programowanie),
  pozytywne(programista, zna, metodyki_wytwarzania_oprogramowania),
  pozytywne(programista, jest, schematyczny).

jest_to(project_menadzer) :-
  kjest(project_manadzer, lider),
  kjest(project_manadzer, negocjator),
  pozytywne(project_manadzer, zna, metodyki_wytwarzania_oprogramowania).

jest_to(architekt) :-
  kjest_to(architekt, programista),
  kjest(architekt, tester),
  pozytywne(architekt, ma, duzy_staz).

jest_to(frontend) :-
  kjest(frontend, esteta),
  kjest(frontend, wizjoner),
  pozytywne(frontend, jest, cierpliwy),
  pozytywne(frontend, sie, angazuje).

jest_to(backend) :-
  kjest(backend, umyslem_scislym),
  pozytywne(backend, jest, dokladny),
  pozytywne(backend, zna, programowanie).

jest_to(producent) :-
  kjest(producent, wizjoner),
  kjest(producent, negocjator),
  not(kjest(producent, ryzykant)),
  pozytywne(producent, ma, duzy_staz).

jest_to(pr) :-
  kjest(pr, wizjoner),
  kjest(pr, esteta),
  pozytywne(pr, zna, praca_w_grupie),
  pozytywne(pr, dobrze, negocjuje),
  pozytywne(pr, jest, asertywny).

jest_to(administrator) :-
  pozytywne(administrator, zna, sieci).

jest_to(analityk) :-
  kjest(analityk, eksperymentator),
  pozytywne(analityk, zna, statystyka).

jest_to(badacz) :-
  kjest(badacz, ryzykant),
  kjest(badacz, eksperymentator),
  pozytywne(badacz, zna, programowanie),
  pozytywne(badacz, zna, statystyka).

jest_to(hr) :-
  kjest(hr, wizjoner),
  kjest(hr, esteta),
  pozytywne(hr, dobrze, negocjuje),
  pozytywne(hr, jest, asertywny).

jest_to(grafik) :-
  kjest(grafik, esteta),
  pozytywne(grafik, zna, photoshop).



kjest(X, Y) :-
  assertz(xwhy('jest_to', '_', X)),
  assertz(xwhy('jest', X, Y)),
  jest(X, Y),
  (xjest(Y);
  assertz(xjest(Y))).

jest(X, tester) :-
  kjest(X, umyslem_scislym),
  pozytywne(X, tester, jest, dokladny),
  pozytywne(X, tester, zna, testowanie).

jest(X, negocjator) :-
  pozytywne(X, negocjator, jest, asertywny),
  pozytywne(X, negocjator, jest, odporny_na_stres),
  pozytywne(X, negocjator, zna, praca_w_grupie),
  pozytywne(X, negocjator, dobrze, negocjuje),
  pozytywne(X, negocjator, lubi, samorozwoj).

jest(X, esteta) :-
  pozytywne(X, esteta, projektuje, ladne_rzeczy),
  pozytywne(X, esteta, jest, dokladny).

jest(X, ryzykant) :-
  pozytywne(X, ryzykant, lubi, ryzyko),
  negatywne(X, ryzykant, patrzy, przyszlosciowo).

jest(X, eksperymentator) :-
  pozytywne(X, eksperymentator, ryzyko),
  pozytywne(X, eksperymentator, przyszlosciowo).

jest(X, lider) :-
  kjest(X, wizjoner),
  pozytywne(X, lider, sie, angazuje),
  pozytywne(X, lider, jest, asertywny).

jest(X, elastyczny) :-
  negatywne(X, elastyczny, lubi, sztywne_godziny_pracy),
  negatywne(X, elastyczny, jest, schematyczny).

jest(X, wizjoner) :-
  pozytywne(X, wizjoner, patrzy, przyszlosciowo),
  pozytywne(X, wizjoner, lubi, eksperymentowac),
  negatywne(X, wizjoner, jest, schematyczny).

jest(X, umyslem_scislym) :-
  pozytywne(X, umyslem_scislym, umie, matematyke);
  pozytywne(X, umyslem_scislym, mysli, logicznie).


pozytywne(_, _, X, Y) :-
  assertz(xwhy('pozytywne', X, Y)),
  xpozytywne(X, Y), !.

pozytywne(H, S, X, Y) :-
  not(xnegatywne(X, Y)),
  pytaj(H, S, X, Y, tak).

pozytywne(_, X, Y) :-
  assertz(xwhy('pozytywne', X, Y)),
  xpozytywne(X, Y), !.

pozytywne(H, X, Y) :-
  not(xnegatywne(X, Y)),
  pytaj(H, H, X, Y, tak).

negatywne(_, _, X, Y) :-
  assertz(xwhy('negatywne', X, Y)),
  xnegatywne(X, Y), !.

negatywne(H, S, X, Y) :-
  not(xpozytywne(X, Y)),
  pytaj(H, S, X, Y, nie).

negatywne(_, X, Y) :-
  assertz(xwhy('negatywne', X, Y)),
  xnegatywne(X, Y), !.

negatywne(H, X, Y) :-
  not(xpozytywne(X, Y)),
  pytaj(H, H, X, Y, nie).


pytaj(H, S, X, Y, K) :-
  !, write(X), write(' nasz_pracownik '), write(Y), write(' ? (t/n)\n'),
  readln([Replay]),

  (pamietaj(H, S, X, Y, Replay),
  odpowiedz(Replay, K);

  (odpowiedz(Replay, what),
  pytaj(H, S, X, Y, K));

  (odpowiedz(Replay, how),
  pytaj(H, S, X, Y, K));

  (odpowiedz(Replay, why),
  pytaj(H, S, X, Y, K));

  (odpowiedz(Replay, help),
  pytaj(H, S, X, Y, K))).

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

pamietaj(H, S, X, Y, Replay) :-
  odpowiedz(Replay, tak),
  assertz(xpozytywne(X, Y)),
  assertz(xhow(H, S, X, Y, 'tak')).

pamietaj(H, S, X, Y, Replay) :-
  odpowiedz(Replay, nie),
  assertz(xnegatywne(X, Y)),
  assertz(xhow(H, S, X, Y, 'nie')).

podaj_what :-
  write('WHAT:\n'),
  write('Hipotezy:\n'),
  setof(K1, xjest_to(K1), L1),
  drukuj_bez_glowy(L1),

  write('\nFakty posrednie:\n'),
  setof(K2, xjest(K2), L2),
  drukuj_bez_glowy(L2),

  write('\nSymptomy na tak:\n'),
  bagof([K31, K32], xpozytywne(K31, K32), L3),
  drukuj_bez_glowy(L3),

  write('\nSymptomy na nie:\n'),
  bagof([K41, K42], xnegatywne(K41, K42), L4),
  drukuj_bez_glowy(L4),
  write('KONIEC WHAT\n').

podaj_why :-
  write('WHY:\n'),
  write('Stos zapytan:\n'),
  bagof([K0, K1, K2], xwhy(K0, K1, K2), L0),
  drukuj_bez_glowy(L0),
  write('KONIEC WHY\n').

podaj_how :-
  podaj_what,
  write('HOW:\n'),
  write('Skad sie wziely fakty posrednie:\n'),
  bagof([F1, F2, F3, F4, F5], (xhow(F1, F2, F3, F4, F5), xjest(F2)), B1),
  % bagof([Fakt1, Fakt2, Fakt3], (xhow(Fakt1, Fakt2, Fakt3)), B1),
  drukuj_bez_glowy(B1),
  write('\nSkad sie wziely hipotezy:\n'),
  % bagof([H1, H2, H3], (xhow(H1, H2, H3), xjest_to(H1)), B2),
  bagof([H1, H2, H3, H4, H5], (xhow(H1, H2, H3, H4, H5), xjest_to(H1)), B2),
  drukuj_bez_glowy(B2),
  write('KONIEC HOW\n').

resetuj_stan :-
  write('\n\nNacisnij enter aby zakonczyc\n'),
  retractall(xpozytywne(_, _)),
  retractall(xnegatywne(_, _)),
  retractall(xwhy(_, _)),
  retractall(xhow(_, _, _, _)),
  readln(_).

drukuj_bez_glowy([_|T]) :-
  drukuj(T).

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
