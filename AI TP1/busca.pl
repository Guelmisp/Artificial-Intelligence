% Problema de busca com Informa��o
% ----- Mundo do aspirador de p�
% ----- Estado Inicial e Meta

% Estado Inicial: 
	inicial([1,s,s]).

% Estado Meta: 
	meta([_,l,l]).

% ------------ Acoes do problema
	acao(entrar1,[2,A,B],[1,A,B],1).
	acao(entrar2,[1,A,B],[2,A,B],1).
	acao(aspirar,[1,s,B],[1,l,B],1).
	acao(aspirar,[2,A,s],[2,A,l],1).

% ------------ funcao heuristica: nula

 h(_,0).


  
/*--------------------------------------------------------------+
| Algoritmo de busca no espa�o de estados                       |  

| Para executar, descreva o problema de busca e digite:		|
| ?- busca(TipoDeBusca). <enter>                                |
+--------------------------------------------------------------*/

% selecione o tipo de busca desejada
% 1- aleatoria
% 2- largura
% 3- profundidade
% 4- menor custo
% 5- melhor estimativa
% 6- otima (ou A*)

busca(T) :-
   inicial(E),
   busca(T,[_:_:0:E:[]],[],P:G),
   tipo(T,N),
   format('~nTipo.: ~w',[N]),
   format('~nPlano: ~w',[P]),
   format('~nCusto: ~w~n~n',[G]).
busca(_,[_:_:G:E:C|_],_,P:G) :- 
   meta(E), !,
   reverse(C,P).
busca(T,[_:_:G:E:C|F],V,P) :- 
   sucessores(T,G:E:C,V,S),
   insere(T,S,F,NF),
   union([E],V,NV),
   busca(T,NF,NV,P).

sucessores(T,G1:E:C,V,R) :-
   findall(F:H:G:S:[A|C],
	   (acaso(A,E,S,G2), 
	    not(member(S,V)),  
	    h(S,H), G is G1+G2, 
	    (T=4 -> F is G
	    ;T=5 -> F is H
	    ;T=6 -> F is G+H
	    ;       F is 0)),R).
insere(1,S,F,NF) :- append(S,F,R), 
                    length(R,L), embaralha(L,R,NF), !.
insere(2,S,F,NF) :- append(F,S,NF), !.
insere(3,S,F,NF) :- append(S,F,NF), !.
insere(_,S,F,NF) :- append(S,F,R), sort(R,NF), !.

embaralha(0,F,F) :- !.
embaralha(L,F,[X|NF]) :- 
   N is random(L), 
   nth0(N,F,X), delete(F,X,R),
   M is L-1,
   embaralha(M,R,NF), !.

tipo(1, aleatoria).
tipo(2, largura).
tipo(3, profundidade).
tipo(4, menor_custo).
tipo(5, melhor_estimativa).
tipo(6, otima).