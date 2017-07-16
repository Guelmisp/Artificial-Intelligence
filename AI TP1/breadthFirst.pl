breadthFirst([[No|Caminho]|_],[No|Caminho]) :- final(No).

breadthFirst([Caminho|OutrosCaminhos],Solucao) :-
  estender(Caminho,NovosCaminhos),
  concatena(OutrosCaminhos,NovosCaminhos,Caminhos1),
  breadthFirst(Caminhos1,Solucao).

estender([No|Caminho],NovosCaminhos) :-
  findall([NovoNo,No|Caminho],
          (s(No,NovoNo), /+ pertence(NovoNo,[No|Caminho])),
          NovosCaminhos).