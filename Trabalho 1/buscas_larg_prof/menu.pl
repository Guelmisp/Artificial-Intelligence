% Problema de busca com informacao.
% Aluno: Miguel Pessoa

% Carrega a Base de Dados Brasil
:- [brasil3].

% Carrega as buscas 
:- [buscaprofundidade].
:- [buscalargura].

final(espiritoSanto).

menu :- repeat,
    write('Brasil - Buscas em Grafo                         '),nl,
    write('   1. Busca Aleatoria                            '),nl,
    write('   2. Busca em Largura                           '),nl,
    write('   3. Busca em Profundidade                      '),nl,
    write('digite sua opcao:'),nl,
    read(Choice), Choice>0, Choice =<7,
    doit(Choice), Choice=7, !.

doit(2):-
	write('Busca em Largura '), nl,
	write('Escreva o estado inicial: '), nl,
	read(Inicial),
    buscalargura([[Inicial]], Solucao),
    write('Solucao: '),nl, write(Solucao), nl.

doit(3):-
	write('Busca em Profundidade '), nl,
	write('Escreva o estado inicial: '), nl,
	read(Inicial),
    buscaprofundidade([], Inicial, Solucao),
    write('Solucao: '),nl, write(Solucao), nl.