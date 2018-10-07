% Daniel Pereira Ferragut, RA 169488
% Victor Ferreira Ferrari, RA 187890

% Projeto 2 de MC346 - Montagem de trechos com interseção
% Programa em Prolog que encontra interseções, com tamanho maior ou igual a 4, entre finais e começos de strings.
% Depois une as strings que possuem interseção, e imprime o resultado.

% Modificado em: 06/10/2018

:- dynamic inter_dic/3.

% Temporaria: transforma em lista de chars e chama intersect.
interchar(X,Y,R) :- clearall(), string_chars(X,XX), string_chars(Y,YY), intersect(XX,YY,RR), string_chars(R,RR).

% Retorna a lista sem o ultimo elemento
init([_],[]).
init([X|XS],[X|R]) :- init(XS,R), !.

% Encontra maior interseção entre duas listas.
intersect([],_,[]).
intersect(_,[],[]).
intersect(X,X,X).
intersect(X,Y,R) :- get(X,Y,R), !.
intersect([X|XS],Y,R) :-  init(Y,YY), 
                          intersect(XS,Y,RR), intersect([X|XS],YY,RRR), 
                          long(RR,RRR,R), !, set([X|XS],Y,R).

% Dadas duas listas, determina a mais longa.
long(X,Y,R) :- length(X,XX), length(Y,YY), (XX > YY -> R = X ; R = Y).


% Funções para manipulação de dicionário
get(CH1,CH2,V) :- inter_dic(CH1,CH2,V).
set(CH1,CH2,V) :- asserta(inter_dic(CH1,CH2,V)).
clearall() :- retractall(inter_dic(_,_,_)).
