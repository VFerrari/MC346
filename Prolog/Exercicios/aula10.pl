homem(antonio).
homem(helu).
homem(chamyto).
homem(foo).
homem(genial).

mulher(gi).
mulher(ana).
mulher(lu).
mulher(rafa).
mulher(manu).

pai(antonio,helu).
pai(chamyto,genial).
pai(chamyto,foo).
pai(foo,rafa).
pai(genial, gi).

mae(lu,genial).
mae(manu,rafa).
mae(manu, gi).
mae(ana,foo).

sibling(X,Y) :- pai(Z,X),mae(W,X),pai(Z,Y),mae(W,Y), X \= Y.
meiosibling(X,Y) :- pai(Z,X),pai(Z,Y),mae(W,X),mae(M,Y), M \= W, X \= Y.
meiosibling(X,Y) :- pai(W,X),pai(P,Y),mae(Z,X),mae(Z,X), W \= P, X \= Y.

irmao(X,Y) :- homem(Y), sibling(X,Y).
meioirmao(X,Y) :- homem(Y), meiosibling(X,Y).

irma(X,Y) :- mulher(Y), sibling(X,Y).
meioirma(X,Y) :- mulher(Y), meiosibling(X,Y).

tio(X,Y) :- pai(Z,Y),irmao(X,Z).
tio(X,Y) :- mae(Z,Y),irmao(X,Z).
tio(X,Y) :- pai(Z,Y),meioirmao(X,Z).
tio(X,Y) :- mae(Z,Y),meioirmao(X,Z).
