buscalargura([[No|Caminho]|_],[No|Caminho]) :- final(No).
buscalargura([Caminho|OutrosCaminhos],Solucao) :-
	estender(Caminho,NovosCaminhos),
	append(OutrosCaminhos,NovosCaminhos,Caminhos1),
	buscalargura(Caminhos1,Solucao).

estender([No|Caminho],NovosCaminhos) :- 
	findall([NovoNo,No|Caminho], 
	(s(No,NovoNo), \+ member(NovoNo,[No|Caminho])), NovosCaminhos).