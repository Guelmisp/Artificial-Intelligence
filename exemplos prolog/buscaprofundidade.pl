

% A relação resolva(Inicio, Solução), onde Inicio é o estado inicial e Solução é o 
% caminho entre estado inicial e estado final.

% --------- Se nó N atual é final, então [N] é o caminho.
resolva(N, [N]):- final(N).

resolva(N, [N|Caminho]):- s(N,N1),
							resolva(N1, Caminho).
s(N,N1):- aresta(N,N1,_).

% -------- Verifica se Nó pertence ao Caminho
pertence(E, [E|_]).
pertence(E,[_|L]):- pertence(E,L).

% ------------------- Fatos
aresta(a,b, 10).
aresta(a,c, 15).
aresta(b,d, 2).
aresta(b,e, 6).
aresta(d,h, 12).
aresta(e,i, 5).
aresta(e,j, 8).
aresta(c,f, 7).
aresta(c,g, 11).
aresta(f,k, 2).
aresta(b,a, 10).
final(j).
final(f).