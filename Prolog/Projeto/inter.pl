% Daniel Pereira Ferragut, RA 169488
% Victor Ferreira Ferrari, RA 187890

% Projeto 2 de MC346 - Montagem de trechos com interseção
% Programa em Prolog que encontra interseções, com tamanho maior ou igual a 4, entre finais e começos de strings.
% Depois une as strings que possuem interseção, e imprime o resultado.

% Modificado em: 06/10/2018

:- dynamic inter_dic/3.

% Temporaria: transforma em lista de chars e chama intersect.
interchar(X,Y,R) :- retractall(known_inter(_,_,_)), string_chars(X,XX), string_chars(Y,YY), intersect(XX,YY,RR), string_chars(R,RR).

% Retorna a lista sem o ultimo elemento
init([_],[]).
init([X|XS],[X|R]) :- init(XS,R), !.

% Encontra interseção entre duas strings
intersect([],_,[]).
intersect(_,[],[]).
intersect(X,X,X).
intersect(X,Y,R) :- inter_dic(X,Y,R), !.
intersect([X|XS],Y,R) :- intersect(XS,Y,RR), init(Y,YY), intersect([X|XS],YY,RRR), long(RR,RRR,R), !, asserta(inter_dic([X|XS],Y,R)).

% Dadas duas listas, determina a mais longa.
long(X,Y,R) :- length(X,XX), length(Y,YY), (XX > YY -> R = X ; R = Y).
