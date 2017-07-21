% Busca em Profundidade
% -------- Insere Elemento No na lista Solucao.
buscaprofundidade(Caminho,No,[No|Caminho]) :- final(No).
buscaprofundidade(Caminho,No,Solucao) :- 
	s(No,No1), 
	\+ member(No1,Caminho), 
	buscaprofundidade([No|Caminho],No1,Solucao).

% -------- Verifica se sao ligadas
s(N,N1):- estrada(N,N1,_).


