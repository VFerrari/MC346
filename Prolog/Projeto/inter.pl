% Daniel Pereira Ferragut, RA 169488
% Victor Ferreira Ferrari, RA 187890

% Projeto 2 de MC346 - Montagem de trechos com interseção
% Programa em Prolog que encontra interseções, com tamanho maior ou igual a 4, entre finais e começos de strings.
% No resto do código, chamaremos de interseção apenas esse tipo.
% Depois une as strings que possuem interseção, e imprime o resultado.

% Modificado em: 18/10/2018
:- initialization(main).

main :-     current_input(Stream),
            read_until_EOF(Stream, [] , Input),
            getComb(Input, _ , Output),
            % write(Output), nl,
            printList(Output),
            halt(0).

printList([]).
printList([X|Y]) :- write(X), nl, printList(Y).

% Temporaria: transforma em lista de chars e chama intersect.
interchar(X,Y,R) :- 
                    % write("Comparando "), write(X), write(" "), write(Y), nl,
                    string_chars(X,XX),string_chars(Y,YY),
                    intersect2(XX,YY,RR),
                    string_chars(R,RR).

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


% Dado uma stream e uma lista inicial, devolve uma lista com as linhas lidas.
read_until_EOF(Stream, Lista, Lista_strings) :-     at_end_of_stream(Stream),
                                                    Lista_strings = Lista.

read_until_EOF(Stream, [], Lista_strings) :-        read_string(Stream, '\n', '\r', _, X),
                                                    read_until_EOF(Stream, [X], Lista_strings), !.

read_until_EOF(Stream, [Lista], Lista_strings) :-   read_string(Stream, '\n', '\r', _, X),
                                                    append([Lista], [X], XLista),
                                                    read_until_EOF(Stream, XLista, Lista_strings), !.

read_until_EOF(Stream, Lista, Lista_strings) :-     read_string(Stream, '\n', '\r', _, X),
                                                    append(Lista,[X], XLista),
                                                    read_until_EOF(Stream, XLista, Lista_strings), !.

%Essa funcao recebe um parametro, + ListaIn, - ListaOut

getComb([], [], []).
getComb(A, ListaMid, ListaOut) :-           length(A, LenA),
                                            % write(LenA),write("Olha aqui : "), write(A),nl,
                                            LenA = 1,
                                            % write("Olha aqui : "), write(A),nl,
                                            getComb(ListaMid, [] , QuaseRes),
                                            stringAppend(A,QuaseRes, ListaOut).

getComb([A,B|Xs], ListaMid, ListaOut) :-    interchar(A, B, CAB), interchar(B, A, CBA),
                                            % write("A="), write(A),nl, write("B="), write(B),nl, write("CAB="), write(CAB),nl, write("CBA="),write(CBA),nl, 
                                            chooseInter(A,B, CAB, CBA, C),
                                            % write("C:"),write(C),nl,
                                            stringAppend(ListaMid, Xs, Merged),
                                            % write("Merged:"), write(Merged), nl,
                                            stringAppend(A, Xs, AXs),
                                            stringAppend(B, ListaMid, BMid),
                                            stringAppend(C, Merged, CMerged),
                                            % write("CMerged:"),write(CMerged),nl,
                                            (A=C->
                                                getComb(AXs, BMid, ListaOut);
                                                getComb(CMerged, [], ListaOut)).

stringAppend([],[],[]).
stringAppend(X, [], R)  :-  (is_list(X) ->  R=X ; R=[X]).
stringAppend([], X, R)  :-  (is_list(X) ->  R=X ; R=[X]).
stringAppend(X,Y,R)     :-  is_list(Y), is_list(X), append(X,Y,R).
stringAppend(X,Y,R)     :-  is_list(Y), append([X],Y,R).
stringAppend(X,Y,R)     :-  is_list(X), append(X,[Y],R).
stringAppend(X,Y,R)     :-  append([X], [Y], R).

chooseInter(A, B,  A, B, A).
chooseInter(_, B,  CAB, B, CAB).
chooseInter(A, _, A, CBA, CBA).
chooseInter(_, _, CAB, CBA, C) :-   string_length(CAB, Len1), string_length(CBA, Len2),
                                    (Len1 = Len2 ->
                                        C = CAB;
                                        (Len1 > Len2 ->
                                            C = CAB;
                                            C = CBA)).
