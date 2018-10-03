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
% 1- Árvores

% Retorna o maior elemento de uma abb
maior(arv(X,_,vazia),X) :- !,true.
maior(arv(_,_,AD),R) :- maior(AD,R).

% Retorna o menor elemento de uma abb
menor(arv(X,vazia,_),X) :- !, true.
menor(arv(_,AE,_),R) :- menor(AE,R).

% Verifica se uma árvore é uma abb
checkBin(vazia).
checkBin(arv(_,vazia,vazia))  :- true.
checkBin(arv(X,AE,vazia)) :- checkBin(AE), maior(AE,R), R<X.
checkBin(arv(X,vazia,AD)) :- checkBin(AD), menor(AD,R), R>X.
checkBin(arv(X,AE,AD))    :- checkBin(AE), checkBin(AD), maior(AE,R), menor(AD,L), X<L, X>R. 

% Insere um item em uma abb
insert(X,vazia,arv(X,vazia,vazia)).
insert(X,arv(X,AE,AD),arv(X,AD,AE)).
insert(X,arv(I,AE,AD),arv(I,R,AD)) :- X < I, insert(X,AE,R), !.
insert(X,arv(I,AE,AD),arv(I,AE,R)) :- X > I, insert(X,AD,R), !.

% Remove um item de uma abb
remove(_,vazia,vazia).
remove(X,arv(I,AE,AD), arv(I,R,AD)) :- X < I, remove(X,AE,R), !.
remove(X,arv(I,AE,AD), arv(I,AE,R)) :- X > I, remove(X,AD,R), !.
remove(X,arv(X,AE,AD), R) :- delete(AD,AE,R).

delete(vazia,vazia,vazia).
delete(vazia,AD,AD).
delete(AE,vazia,AE).
delete(AE,AD,arv(M,AE,R)) :- menor(AD,M), remove(M,AD,R).

% Calcula a profundidade máxima de uma abb
depth(vazia,0).
depth(arv(_,AE,AD),R) :- depth(AE,E), depth(AD,D), (E > D -> R is E+1 ; R is D+1).

% Converte abb em uma lista em ordem infixa (esq,no,dir).
inOrder(vazia,[]).
inOrder(arv(X,AE,AD),R) :- inOrder(AE,E), inOrder(AD,D), append(E,[X|D],R).

% Converte abb em uma lista em ordem prefixa (no, esq, dir)
preOrder(vazia,[]).
preOrder(arv(X,AE,AD),R) :- preOrder(AE,E), preOrder(AD,D), append([X|E],D,R).

% Converte uma lista em abb
buildTree([],vazia).
buildTree([X|XS],R) :- buildTree(XS,T), insert(X,T,R), !.

% 2- Dicionários

% Insere um par chave valor no dicionario (ou troca o valor associado a chave se ela já está no dicionario)
insertKey(K,V,[],[dic(K,V)]) :- !, true.
insertKey(K,NV,[dic(K,_)|R],[dic(K,NV)|R]) :- !, true.
insertKey(K,V,[dic(KK,VV)|R],[dic(KK,VV)|RR]) :- insertKey(K,V,R,RR).  

% Remove uma chave (e seu valor) do dicionário
removeKey(_,[],[]) :- !, true.
removeKey(K,[dic(K,_)|R],R) :- !, true.
removeKey(K,[dic(KK,VV)|R],[dic(KK,VV)|RR]) :- removeKey(K,R,RR).

% Contador: dicionario onde valor associado é um inteiro. 
% Dado um contador soma um ao valor associado a uma chave, ou se ela nao estiver no dicionario, acrescenta a chave com valor 1.
add1(K,[],[dic(K,1)]) :- !, true.
add1(K,[dic(K,V)|R],[dic(K,VV)|R]) :- VV is V+1, !.
add1(K,[dic(KK,VV)|R],[dic(KK,VV)|RR]) :- add1(K,R,RR).

% Exercícios extras:
% Conta os nos de uma abb
countNodes(vazia,0).
countNodes(arv(_,AE,AD),R) :- countNodes(AD,R1),countNodes(AE,R2), R is R1+R2+1.

% Soma os nos de uma abb
sumNodes(vazia,0).
sumNodes(arv(N,AE,AD),R) :- sumNodes(AD,R1),sumNodes(AE,R2), R is R1+R2+N.

% Converte abb em uma lista em ordem posfixa (esq,dir,no)
postOrder(vazia,[]).
postOrder(arv(N,AE,AD),R) :- postOrder(AE,R1),postOrder(AD,R2), append(R1,R2,RR), append(RR,[N],R).

% Realiza busca em largura em uma abb
levelOrder(X,R) :- levelOrder2([X],R).
levelOrder2([],[]).
levelOrder2([vazia|XS],R) :- levelOrder2(XS,R), !.
levelOrder2([arv(N,AE,AD)|XS],[N|R]) :- append(XS,[AE,AD],RR), levelOrder2(RR,R).
