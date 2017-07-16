% Busca em Largura em PROLOG
% A relação resolva(Inicio, Solução), onde Inicio é o estado inicial e Solução é o caminho entre estado inicial e estado final.
resolva(No,Solucao) :- buscalargura([[No]],Solucao).

% buscalargura([Caminho1,Caminho2,...],Solucao), Solucao é uma extensão para um nó final de um dos caminhos.
buscalargura([[No|Caminho]|_],[No|Caminho]) :- final(No).
buscalargura([Caminho|OutrosCaminhos],Solucao) :- 	estender(Caminho,NovosCaminhos),
													concatena(OutrosCaminhos,NovosCaminhos,Caminhos1),
													buscalargura(Caminhos1,Solucao).
													
estender([No|Caminho],NovosCaminhos) :- findall([NovoNo,No|Caminho], 
											   (s(No,NovoNo), /+ pertence(NovoNo,[No|Caminho])), 
											    NovosCaminhos).


s(N,N1):- aresta(N,N1).

% -------- Verifica se Elemento E pertence a uma Lista
pertence(E,[E|_]).
pertence(E,[_|L]):- pertence(E,L).

% Concatena duas Listas.
concatena([],L,L).
concatena([X|L1],L2,[X|L3]):- concatena(L1,L2,L3).



% ------------------- Fatos
aresta(a,b).
aresta(a,c).
aresta(b,d).
aresta(b,e).
aresta(d,h).
aresta(e,i).
aresta(e,j).
aresta(c,f).
aresta(c,g).
aresta(f,k).
final(j).
final(f).