%fatos

mulher(ana).
mulher(eva).
mulher(clo).
homem(bob).
homem(ivo).
homem(rui).
homem(rai).

%casal(ana,bob).
%casal(eva, ivo).
%casal(clo,rui).

gerou(ana,clo).
gerou(bob,clo).
gerou(clo,bia).
gerou(rui,bia).
gerou(eva,rai).
gerou(eva,rui).
gerou(ivo,rui).
gerou(ivo,rai).

%Regras
casal(X,Y) :- gerou(X,Z), gerou(Y,Z), X\==Y.

mae(X,Y) :- gerou(X,Y), mulher(X).

pai(X,Y) :- gerou(X,Y), homem(X).

avo(X,Y) :- mae(X,Z), gerou(Z, Y).

avoh(X,Y) :- pai(X,Z), gerou(Z, Y).

irmao(X,Y) :- pai(A,X), mae(B,Y), casal(A,B).

tio(X,Y) :- irmao(Z,X), pai(Z,Y).
