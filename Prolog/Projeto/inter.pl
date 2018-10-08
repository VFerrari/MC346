% Daniel Pereira Ferragut, RA 169488
% Victor Ferreira Ferrari, RA 187890

% Projeto 2 de MC346 - Montagem de trechos com interseção
% Programa em Prolog que encontra interseções, com tamanho maior ou igual a 4, entre finais e começos de strings.
% No resto do código, chamaremos de interseção apenas esse tipo.
% Depois une as strings que possuem interseção, e imprime o resultado.

% Modificado em: 06/10/2018

:- dynamic inter_dic/3.

% Temporaria: transforma em lista de chars e chama intersect.
interchar(X,Y,R) :- clearall(), string_chars(X,XX), string_chars(Y,YY), intersect2(XX,YY,RR), string_chars(R,RR).

% Retorna a lista sem o ultimo elemento
init([_],[]).
init([X|XS],[X|R]) :- init(XS,R), !.

% V1
% Encontra maior interseção entre duas listas (ainda não verifica se tem tamanho 4 ou maior).
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



% V2, mais curto mas menos legal :(
% Não precisa do dicionário, e já devolve a string final. Ver se não é lento demais com o programa final.
% Função que junta duas strings se há uma interseção.
intersect2([],_,[]).
intersect2([X|XS],Y,R) :- (valid([X|XS],Y) -> 
                            (prefix([X|XS],Y) -> R = Y ; 
                          	    intersect2(XS,Y,RR), R = [X|RR]) ;
                            R = [X|XS]).

% Verifica se duas strings têm tamanho 4 ou mais.
valid(X,Y) :- length(X,XX), length(Y,YY), XX >= 4, YY >= 4.


%Dado uma stream e uma lista inicial, devolve uma lista com as linhas lidas.
read_until_EOF(Stream, Lista, Lista_strings) :-     at_end_of_stream(Stream),
                                                    Lista_strings = Lista.
read_until_EOF(Stream, [], Lista_strings) :-        read_string(Stream, '\n', '\r', _, X),
                                                    read_until_EOF(Stream, [X], Lista_strings), !.
read_until_EOF(Stream, [Lista], Lista_strings) :-   read_string(Stream, '\n', '\r', _, X),
                                                    read_until_EOF(Stream, [X:Lista], Lista_strings), !.

