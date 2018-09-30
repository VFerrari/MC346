% Aula: Teste - Remove item da lista (1 vez só).

maximo([X],X).
maximo([X|R],M) :- maximo(R,MM), (MM > X ->  M = MM ; M = X).

% Exercícios: 

% Maior elemento de uma lista (com acumulador)
maior([X|R],M) :- maior(R,M,X).
maior([],M,M).
maior([X|R],M,Acc) :- X > Acc, maior(R,M,X).
maior([X|R],M,Acc) :- maior(R,M,Acc).

% Gera lista de 1 a N-1
gera(N,L) :- gera(N,L,1).
gera(N,[],N).
gera(N,[X|LL],X) :- XX is X+1, gera(N,LL,XX).
