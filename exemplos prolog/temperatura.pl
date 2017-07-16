/* Fatos */
temp(phx, 100).
temp(sf, 68).

pai(adao, cain).
pai(adao, abel).
pai(adao, seth).
pai(seth, enos).

pais(brasil, 9, 130).
pais(china, 12, 1800).
pais(eua, 9, 230).
pais(india, 3, 450).

func(1, ana, 1000.90).
func(2, bia, 1200.00).
func(3, ivo, 903.50).

dep(1, ary).
dep(2, rai).
dep(3, eva).


/* Regras */
avo(X,Y) :- pai(X,Z), pai(Z,Y).
irmao(X,Y) :- pai(Z,X), pai(Z,Y), X\=Y.

temp_celc(Local, C_temp) :- temp(Local, F_temp),
	C_temp is (F_temp - 32) * 5/9.

densidade(Pais, D) :- pais(Pais, A, P), D is P/A.




