% Aula:
tam([],0).
tam([_|R],T) :- tam(R,TT), T is TT + 1.

tam2(L,T) :- tam2(L,T,0).
tam2([],T,A) :- T = A.
tam2([_|R], T, A) :- AA is A+1, tam2(R,T,AA).

soma([],0).
soma([X|XS],S) :- soma(XS,SS), S is SS+X.

gera(0,[]).
gera(N,L) :- NN is N-1, gera(NN,LL), L = [N|LL].

% Exercícios:
 
% Auxiliares: verifica se um numero é par ou ímpar
par(N) :- 0 is mod(N,2).
impar(N) :- 1 is mod(N,2).

% Soma os números pares de uma lista
somap([],0).
somap([L|LS],S) :- par(L), somap(LS,SS), S is SS+L.
somap([L|LS],S) :- impar(L), somap(LS,S). 

% Soma os numeros nas posicoes pares
somapares(L,S) :- somapares(L,S,1).
somapares([],0,_).
somapares([L|LS],S,P) :- par(P), PP is P+1, somapares(LS, SS, PP), S is SS+L.
somapares([_|LS],S,P) :- impar(P), PP is P+1, somapares(LS, S, PP).

% Verifica se existe item na lista.
elem(I, [I|_]).
elem(I, [_|LS]) :- elem(I,LS).

% Posição do item na lista
pos(I,L,P) :- pos(I,L,P,1).
pos(I,[I|_],A,A).
pos(I,[_|LS],P,A) :- AA is A+1, pos(I,LS,P,AA).

% Conta quantas vezes o item aparece na lista
conta(_,[],0).
conta(I,[I|LS],C) :- conta(I,LS,CC), C is CC+1.
conta(I,[_|LS],C) :- conta(I,LS,C).

% Encontra o maior elemento da lista (sem acumulador)
maior([L],L).
maior([L|LS],L) :- maior(LS,MM), MM =< L.
maior([_|LS],MM) :- maior(LS,MM).

% Reverte uma lista
reverte([L|LS],R) :- reverte(LS,R,[L]).
reverte([],A,A).
reverte([L|LS],R,A) :- reverte(LS,R,[L|A]).

% Intercala 2 listas
intercala1(_,[],[]).
intercala1([],_,[]).
intercala1([X|XS],[Y|YS],[X,Y|RR]) :- intercala1(XS,YS,RR).

intercala2(X,[],X).
intercala2([],Y,Y).
intercala2([X|XS],[Y|YS],[X,Y|RR]) :- intercala2(XS,YS,RR).

% Verifica se a lista já está ordenada
sorted([]).
sorted([_]).
sorted([X,Y|LS]) :- X =< Y, sorted(LS).

% Retorna o ultimo elemento de uma lista
last([L],L).
last([_|LS],R) :- last(LS,R).

% Retorna a lista sem o utlimo elemento
init([],[]).
init([_],[]).
init([L|LS],[L|RR]) :- init(LS,RR).

% Shift Right
shiftr([],[]).
shiftr(L,R) :- shiftr(L,R,[]).
shiftr([L],[L|A],A).
shiftr([L|LS],R,A) :- append(A,[L],AA), shiftr(LS,R,AA).

% Shift Right n vezes
shiftrn(_,[],[]).
shiftrn(0,L,L).
shiftrn(N,L,R) :- NN is N-1, shiftrn(NN,L,RR), shiftr(RR,R).

% Shift Left
shiftl([],[]).
shiftl([L|LS],R) :- append(LS,[L],R). 

% Shift Left n vezes
shiftln(_,[],[]).
shiftln(0,L,L).
shiftln(N,L,R) :- NN is N-1, shiftln(NN,L,RR), shiftl(RR,R).

% Remove um item da lista (1 vez só)
rm(_,[],[]).
rm(I,[I|LS],LS).
rm(I,[L|LS],[L|RR]) :- rm(I,LS,RR).

% Remove um item da lista (todas as vezes)
rmAll(_,[],[]).
rmAll(I,[I|LS],R) :- rmAll(I,LS,R).
rmAll(I,[L|LS],[L|RR]) :- rmAll(I,LS,RR).

% Troca item velho por novo (1 vez só)
troca1(_,_,[],[]).
troca1(V,NO,[V|LS],[NO|LS]).
troca1(V,NO,[L|LS],[L|RR]) :- troca1(V,NO,LS,RR).

% Troca item velho por novo (todas as vezes)
trocaAll(_,_,[],[]).
trocaAll(V,NO,[V|LS],[NO|RR]) :- trocaAll(V,NO,LS,RR).
trocaAll(V,NO,[L|LS],[L|RR]) :- trocaAll(V,NO,LS,RR).

% Troca item velho por novo (primeiras n vezes)
trocaN(_,_,_,[],[]).
trocaN(0,_,_,L,L).
trocaN(N,V,NO,[V|LS],[NO,RR]) :- N > 0, NN is N-1, trocaN(NN,V,NO,LS,RR).
trocaN(N,V,NO,[L|LS],[L|RR]) :- N > 0, trocaN(N,V,NO,LS,RR).

% Remove um item da lista (a última vez que aparece).
rmUlt(_,[],[]).
rmUlt(I,L,R) :- reverte(L,X), rm(I,X,Y), reverte(Y,R).
