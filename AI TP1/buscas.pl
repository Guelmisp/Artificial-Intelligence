% Busca em Profundidade
depthFirst(Caminho,No,[No|Caminho]) :- final(No).

depthFirst(Caminho,No,Solucao) :-
     s(No,No1),
     \+ member(No1,Caminho),
     depthFirst([No|Caminho],No1,Solucao).

% Busca em Largura
breadthFirst([[No|Caminho]|_],[No|Caminho]) :- final(No).

breadthFirst([Caminho|OutrosCaminhos],Solucao) :- 
  estender(Caminho,NovosCaminhos),
  concatena(OutrosCaminhos,NovosCaminhos,Caminhos1),
  breadthFirst(Caminhos1,Solucao).

% Extras %
estender([No|Caminho],NovosCaminhos) :-
  findall([NovoNo,No|Caminho],
          (s(No,NovoNo), \+ pertence(NovoNo,[No|Caminho])),
          NovosCaminhos).     

s(No,No1):- estrada(N,N1,_).

% Verifica se o No perternce ao caminho
pertence(E,[E|_]).
pertence(E,[_|T]) :- pertence(E,T).

concatena([],L,L).
concatena([X|L1],L2,[X|L3]):- concatena(L1,L2,L3).