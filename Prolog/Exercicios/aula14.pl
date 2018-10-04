% Aula:

:- dynamic pai/2.

soma1(CH,DIC,NDIC) :- append(A,[dic(CH,V)|B],DIC)
		   -> VV is V+1, append(A,[dic(CH,VV)|B], NDIC)
		   ; NDIC = [dic(CH,1)|DIC].

map1(_,[]).
map1(P,[X|R]) :- G=..[P,X], call(G), map1(P,R).

pos(X) :- X>0.
ss(X,Y) :- Y is X+1.

pai(a,b).
pai(a,c).
pai(b,e).
pai(c,f).

ant(A,B) :- pai(A,B).
ant(A,B) :- pai(A,C),ant(C,B).

% Exercicios extras:
% Soma dos valores de uma lista numérica (alto nivel)
soma(X,Y,R) :- R is X+Y.
somaL(X,R) :- foldl(soma,X,0,R).

% Conta elementos de uma lista (alto nível)
plus1(_,X,R) :- R is X+1.
tam(X,R) :- foldl(plus1,X,0,R).

% Soma numeros pares de uma lista (alto nível)
somaPar(X,A,R) :- L is mod(X,2), (L == 0 -> R is A+X ; R is A).
somap(X,R) :- foldl(somaPar,X,0,R).

% Conta quantas vezes um item aparece na lista (alto nível)
igual(X,X).
amount(X,L,R) :- include(igual(X),L,RR), tam(RR,R).

% Remove item da lista (todas as vezes, alto nível)
diferente(X,Y) :- X \= Y.
rmAll(I,L,R) :- include(diferente(I),L,R).
