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
par(N) :- Y = mod(N,2), Y =:= 0.
impar(N) :- Y = mod(N,2), Y \= 0.

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
elem(I,[L|_]) :- L =:= I.
elem(I,[L|LS]) :- L \= I, elem(I,LS).

% Posição do item na lista
pos(I,L,P) :- pos(I,L,P,1).
pos(_,[],0,_).
pos(I,[L|_],P,A) :- I =:= L, P = A.
pos(I,[L|LS],P,A) :- I \= L, AA is A+1, pos(I,LS,P,AA).

% Conta quantas vezes o item aparece na lista
conta(_,[],0).
conta(I,[L|LS],C) :- L =:= I, conta(I,LS,CC), C is CC+1.
conta(I,[L|LS],C) :- L \= I, conta(I,LS,C).

% Encontra o maior elemento da lista
maior([L|[]],L).
maior([L|LS],MM) :- maior(LS,MM), MM > L.
maior([L|LS],M) :- maior(LS,MM), MM =< L, M = L.

% Reverte uma lista
reverte(L,R) :- reverte(L,R,[]).
reverte([],A,A).
reverte([L|LS],R,A) :- reverte(LS,R,[L|A]).

% Intercala 2 listas
intercala1(_,[],[]).
intercala1([],_,[]).
intercala1([X|XS],[Y|YS],R) :- intercala1(XS,YS,RR), R = [X,Y|RR].

intercala2(X,[],X).
intercala2([],Y,Y).
intercala2([X|XS],[Y|YS],R) :- intercala2(XS,YS,RR), R = [X,Y|RR].

% Verifica se a lista já está ordenada
sorted([]).
sorted([_|[]]).
sorted([X,Y|LS]) :- X =< Y, sorted(LS).

% Retorna o ultimo elemento de uma lista
last([],[]).
last([L|[]],L).
last([_|LS],R) :- last(LS,R).

% Retorna a lista sem o utlimo elemento
init([],[]).
init([_|[]],[]).
init([L|LS],R) :- init(LS,RR), R = [L|RR].

% Shift Right
shiftr([],[]).
shiftr(L,R) :- shiftr(L,R,[]).
shiftr([L|[]],R,A) :- R = [L|A].
shiftr([L|LS],R,A) :- append(A,[L],AA), shiftr(LS,R,AA).

% Shift Right n vezes
shiftrn(_,[],[]).
shiftrn(0,L,L).
shiftrn(N,L,R) :- N > 0, NN is N-1, shiftrn(NN,L,RR), shiftr(RR,R).

% Shift Left
shiftl([],[]).
shiftl([L|LS],R) :- append(LS,[L],R). 

% Shift Left n vezes
shiftln(_,[],[]).
shiftln(0,L,L).
shiftln(N,L,R) :- N > 0, NN is N-1, shiftln(NN,L,RR), shiftl(RR,R).

% Remove um item da lista (1 vez só)
rm(_,[],[]).
rm(I,[L|LS],R) :- L =:= I, R = LS.
rm(I,[L|LS],R) :- L \= I, rm(I,LS,RR), R = [L|RR].

% Remove um item da lista (todas as vezes)
rmAll(_,[],[]).
rmAll(I,[L|LS],R) :- L =:= I, rmAll(I,LS,R).
rmAll(I,[L|LS],R) :- L \= I, rmAll(I,LS,RR), R = [L|RR].

% Troca item velho por novo (1 vez só)
troca1(_,_,[],[]).
troca1(V,NO,[L|LS],R) :- L =:= V, R = [NO|LS].
troca1(V,NO,[L|LS],R) :- L \= V, troca1(V,NO,LS,RR), R = [L|RR].

% Troca item velho por novo (todas as vezes)
trocaAll(_,_,[],[]).
trocaAll(V,NO,[L|LS],R) :- L =:= V, trocaAll(V,NO,LS,RR), R = [NO|RR].
trocaAll(V,NO,[L|LS],R) :- L \= V, trocaAll(V,NO,LS,RR), R = [L|RR].

% Troca item velho por novo (primeiras n vezes)
trocaN(_,_,_,[],[]).
trocaN(0,_,_,L,L).
trocaN(N,V,NO,[L|LS],R) :- N \= 0, L =:= V, NN is N-1, trocaN(NN,V,NO,LS,RR), R = [NO|RR].
trocaN(N,V,NO,[L|LS],R) :- N \= 0, L \= V, trocaN(N,V,NO,LS,RR), R = [L|RR].

% Remove um item da lista (a última vez que aparece).
rmUlt(_,[],[]).
rmUlt(I,L,R) :- reverte(L,X), rm(I,X,Y), reverte(Y,R).
