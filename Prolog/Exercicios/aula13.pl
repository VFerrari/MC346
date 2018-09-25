% Aula:
append([],X,X).
append([X|RX],Y,[X|RR]) :- append(RX,Y,RR).

nota(N,L) :- N>9,!,L=a.
nota(N,L) :- N>7,!,L=b.
nota(N,L) :- N>5,!,L=c.
nota(_,d).

% Achar na abb
acha(_,vazia) :- !,fail.
acha(X,arv(X,_,_)).
acha(X,arv(N,AE,AD)) :- X<N -> acha(X,AE) ; acha(X,AD).

% Acessar um dicionario
acessa(CH,[dic(CH,V)|_],V).
acessa(CH,[_|R],V) :- acessa(CH,R,V).

access(CH,DIC,V) :- append(_,[dic(CH,V)|_],DIC).

% Exercícios:
