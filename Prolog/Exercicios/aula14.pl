% Aula:

:- dynamic pai/2.

soma1(CH,DIC,NDIC) :- append(A,[dic(CH,V)|B],DIC)
		   -> VV is V+1, append(A,[dic(CH,VV)|B], NDIC)
		   ; NDIC = [dic(CH,1)|DIC].

map1(_,[]).
map1(P,[X|R]) :- G=..[P,X], call(G), map1(P,R).

pos(X) :- X>0.
ss(X,Y) :- Y is X+1.

pai(a,b).
pai(a,c).
pai(b,e).
pai(c,f).

ant(A,B) :- pai(A,B).
ant(A,B) :- pai(A,C),ant(C,B).

% Exercicios:
% Não tem...
