% Universidade Federal de Ouro Preto
% DECSI - UFOP

% Exemplos da Disciplina Inteligência Artificial - 2017/1

% ----------------------------- FATOS (CONHECIMENTO)
progenitor(maria,joao). 
progenitor(jose,joao). 
progenitor(maria,ana). 
progenitor(jose,ana).    
progenitor(joao,mario).
progenitor(ana,helena).  
progenitor(ana,joana).  
progenitor(helena,carlos). 
progenitor(mario,carlos). 

sexo(ana,feminino).
sexo(maria,feminino).
sexo(joana,feminino).
sexo(helena,feminino).
sexo(mario,masculino).
sexo(joao,masculino).
sexo(jose,masculino).
sexo(carlos,masculino).

% ----------------------------- PREDICADOS (REGRAS)

irma(X,Y):- progenitor(A,X), progenitor(A,Y), X\==Y, sexo(X,feminino).
irmao(X,Y):- progenitor(A,X), progenitor(A,Y), X\==Y, sexo(X,masculino).

% X é descendente de Y
descendente(X,Y):- progenitor(X,Y).
descendente(X,Y):- progenitor(X,A), descendente(A,Y).

avo(X,Y):- progenitor(X,A), progenitor(A,Y), sexo(X,masculino).

mae(X,Y):- progenitor(X,Y), sexo(X,feminino).

pai(X,Y):- progenitor(X,Y), sexo(X,masculino).

tio(X,Y):- irmao(X,A), progenitor(A,Y).

primo(X,Y):- irmao(A,B), progenitor(A,X), progenitor(B,Y), X\==Y.
primo(X,Y):- irma(A,B), progenitor(A,X), progenitor(B,Y), X\==Y.

% ------------------------------ QUESTOES EXEMPLO
% Para recuperar as respostas das consultas abaixo basta digitar o termo antecedente ao IF (:-)
% Exemplo: ?- q4(X).
% Retornará todos aqueles que tem um tio.

% findall => produz uma lista L de todos objetos X que satisfazem o objetivo O. 
% findall(Object,Goal,List). Veja os exemplos abaixo.

q1:- progenitor(jose,joao).
q1b:- pai(jose,joao).
q2(X):- mae(maria,X).
q2b(L):- findall(X,mae(maria,X),L).
q3(X):- primo(mario,X).
q3b(L):- findall(X,primo(mario,X),L).
q3c(L):- findall(X,primo(mario,X),LR),list_to_set(LR,L).
q4(X):- tio(_,X).
q4b(L):- findall(X,tio(_,X),LR),list_to_set(LR,L).
q5(X):- descendente(X,carlos).
q5b(L):- findall(X,descendente(X,carlos),L).
q6a(X):- irmao(helena,X).
q6b(X):- irma(helena,X).

