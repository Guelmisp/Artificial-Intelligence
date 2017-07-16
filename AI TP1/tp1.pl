% Problema de busca com informacao.
% Aluno: Miguel Pessoa

% Carrega a Base de Dados Brasil
:- [brasil].

% Carrega as buscas 
:- [buscas].

final(espiritoSanto).

menu :- repeat,
    write('Brasil - Buscas em Grafo                      '),nl,
    write('   1. Busca Aleatoria                            '),nl,
    write('   2. Busca em Largura                           '),nl,
    write('   3. Busca em Profundidade                      '),nl,
    write('   4. Busca Menor Custo                          '),nl,
    write('   5. Busca Melhor Estimativa                    '),nl,
    write('   6. Busca Otima                                '),nl,
    write('digite sua opcao:'),nl,
    read(Choice), Choice>0, Choice =<7,
    doit(Choice), Choice=7, !.

doit(2):-
	write('Busca em Largura '), nl,
	write('Escreva o estado inicial: '), nl,
	read(Inicial),
	breadthFirst([[Inicial]], Solucao),
    write('Solucao: '),nl, write(Solucao), nl.

doit(3):-
	write('Busca em Profundidade '), nl,
	write('Escreva o estado inicial: '), nl,
	read(Inicial),
	depthFirst([], Inicial, Solucao),
    write('Solucao: '),nl, write(Solucao), nl.