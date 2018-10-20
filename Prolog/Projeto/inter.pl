% Daniel Pereira Ferragut, RA 169488
% Victor Ferreira Ferrari, RA 187890

% Projeto 2 de MC346 - Montagem de trechos com interseção
% Programa em Prolog que encontra interseções, com tamanho maior ou igual a 4, entre finais e começos de strings.
% No resto do código, chamaremos de interseção apenas esse tipo.
% Depois une as strings que possuem interseção, e imprime o resultado.
% Faz isso para todo o conjunto de strings, tal que o conjunto final seja o menor possível.

% Modificado em: 19/10/2018

:- initialization(main).

main :-     current_input(Stream),				% Verifica input
            read_until_EOF(Stream, [] , Input), 		% Lê entrada
            getComb(Input, _ , Output), 			% Processa
            printList(Output),  				% Imprime saída
            halt(0).						% Termina

% Dado uma stream e uma lista inicial, devolve uma lista com as linhas lidas.
read_until_EOF(Stream, List, String_list) :-     at_end_of_stream(Stream),
                                                 String_list = List.

read_until_EOF(Stream, [], String_list) :-       read_string(Stream, '\n', '\r', _, X),
                                                 read_until_EOF(Stream, [X], String_list), !.

read_until_EOF(Stream, [List], String_list) :-   read_string(Stream, '\n', '\r', _, X),
                                                 append([List], [X], XList),
                                                 read_until_EOF(Stream, XList, String_list), !.

read_until_EOF(Stream, List, String_list) :-     read_string(Stream, '\n', '\r', _, X),
                                                 append(List,[X], XList),
                                                 read_until_EOF(Stream, XList, String_list), !.

% Função principal do programa: dada a entrada, procura interseções entre todas as strings.
% Junta as strings que tiverem interseção, e repete o processo.
% Uma de cada vez, verifica interseção com todas as outras strings. Começa de novo se juntar.
getComb([], [], []).
getComb([A], MidList, OutList) :-         getComb(MidList, [] , PartSol),
                                          stringAppend([A], PartSol, OutList).

getComb([A,B|Xs], MidList, OutList) :-    interString(A,B,CAB,CBA),
                                          chooseInter(A,B,CAB, CBA, C),
                                          stringAppend(MidList, Xs, Merged),
                                          stringAppend(A, Xs, AXs),
                                          stringAppend(B, MidList, BMid),
                                          stringAppend(C, Merged, CMerged),
                                          (A=C->
                                              getComb(AXs, BMid, OutList);
                                              getComb(CMerged, [], OutList)).

% Função que recebe duas strings e aplica "intersect" dos dois lados.
interString(A,B,CAB,CBA) :- 	string_chars(A,LA), string_chars(B,LB),
			        intersect(LA, LB, LAB), intersect(LB, LA, LBA),
			        string_chars(CAB,LAB), string_chars(CBA,LBA).

% Encontra maior interseção entre duas strings, e devolve a junção entre ambas se houver.
% Retorna a primeira se não houver interseção.
% Sempre olha o final da primeira com o início da segunda.
% Verifica se uma string é prefixo da outra, e se não for repete com um caractere a menos.
intersect([],_,[]).
intersect([X|XS],Y,R) :- (valid([X|XS],Y) ->
                            (prefix([X|XS],Y) -> R = Y ;
                          	    intersect(XS,Y,RR), R = [X|RR]) ;
                            R = [X|XS]).

% Verifica se duas strings têm tamanho 4 ou mais.
valid(X,Y) :- length(X,XX), length(Y,YY), XX >= 4, YY >= 4.

% Função que junta duas strings, verificando se os argumentos são listas ou elementos.
stringAppend([],[],[]).
stringAppend(X, [], R)  :-  (is_list(X) ->  R=X ; R=[X]).
stringAppend([], X, R)  :-  (is_list(X) ->  R=X ; R=[X]).
stringAppend(X,Y,R)     :-  is_list(Y), is_list(X), append(X,Y,R).
stringAppend(X,Y,R)     :-  is_list(Y), append([X],Y,R).
stringAppend(X,Y,R)     :-  is_list(X), append(X,[Y],R).
stringAppend(X,Y,R)     :-  append([X], [Y], R).

% Escolhe string para continuar o processo, entre uma dupla.
% Se não houver interseção, retorna a primeira string.
% Se houver uma interseção, retorna a junção.
% Se houver duas interseções, retorna a maior (tamanho igual=primeira)
chooseInter(A, B,  A, B, A).
chooseInter(_, B,  CAB, B, CAB).
chooseInter(A, _, A, CBA, CBA).
chooseInter(_, _, CAB, CBA, C) :-   string_length(CAB, Len1), string_length(CBA, Len2),
                                    (Len1 < Len2 ->
                                        C = CBA;
                                        C = CAB).

% Função que imprime uma lista de strings, elemento a elemento.
printList([]).
printList([X|Y]) :- write(X), nl, printList(Y).
