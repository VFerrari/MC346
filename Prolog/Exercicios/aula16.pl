% Aula: Nada

% Teste:
% Insere um item em uma abb-dicionário
insereabb(C,V,vazia,arv(C,V,vazia,vazia)).
insereabb(C,_,arv(C,_,_,_),vazia) :- fail.
insereabb(C,V,arv(CC,VV,AE,AD),arv(CC,VV,R,AD)) :- C < CC, insereabb(C,V,AE,R),!.
insereabb(C,V,arv(CC,VV,AE,AD),arv(CC,VV,AE,R)) :- C > CC, insereabb(C,V,AD,R),!.

% Troca um item em uma abb-dicionário
trocaabb(_,_,vazia,vazia) :- fail.
trocaabb(C,V,arv(C,_,AE,AD),arv(C,V,AE,AD)).
trocaabb(C,V,arv(CC,VV,AE,AD),arv(CC,VV,R,AD)) :- C < CC, trocaabb(C,V,AE,R),!.
trocaabb(C,V,arv(CC,VV,AE,AD),arv(CC,VV,AE,R)) :- C > CC, trocaabb(C,V,AD,R),!.

% Procura o valor de uma chave em uma abb-dicionário
lookupabb(_,_,vazia,_) :- fail.
lookupabb(C,arv(C,V,_,_),V).
lookupabb(C,arv(CC,_,AE,AD),R) :- C > CC -> lookupabb(C,AD,R) ; lookupabb(C,AE,R).

% Procura o valor de uma chave em um dicionário-abb
getdic(C,DIC,R) :- lookupabb(C,DIC,R).

% Procura o valor de uma chave em um dicionário-abb, e coloca um default se não existir.
xgetdic(C,DIC,DEF,R) :- lookupabb(C,DIC,RR) -> R is RR ; R is DEF.

% Insere ou troca um valor em um dicionário-abb
putdic(C,V,DIC,R) :- insereabb(C,V,DIC,RR) -> R = RR ; trocaabb(C,V,DIC,R).
