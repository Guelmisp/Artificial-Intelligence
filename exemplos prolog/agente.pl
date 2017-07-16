agente :-
   inicia,
   new(D,dialog('Agente')),
   send(D,append,bitmap(image('ambiente.bmp'))),
   send(D,display,new(@o1,box(20,20))),
   send(@o1,fill_pattern,colour(yellow)),
   send(@o1,move,point(20,30)),
   send(D,display,new(@o2,box(20,20))),
   send(@o2,fill_pattern,colour(green)),
   send(@o2,move,point(20,50)),
   send(D,display,new(@o3,box(20,20))),
   send(@o3,fill_pattern,colour(red)),
   send(@o3,move,point(20,70)),
   send(D,append,new(@a,bitmap(image('agente.bmp')))),
   send(@a,move,point(235,237)),
   new(@t,timer(1)),
   send(@t,start),
   send(D,open).

:- dynamic pos/2, seg/1.

inicia :-
   forall(member(X,[@t,@a,@o1,@o2,@o3]),free(X)),
   retractall(pos(_,_)),
   retractall(seg(_)),
   assert(pos(agente,9)),
   assert(pos(1,1)),
   assert(pos(2,1)),
   assert(pos(3,1)).

porta(1,4).
porta(2,5).
porta(3,6).
porta(4,5).
porta(4,7).
porta(5,6).
porta(5,8).
porta(6,9).

passagem(X,Y) :- porta(X,Y).
passagem(X,Y) :- porta(Y,X).

rota(X,X,[X]) :- !.
rota(X,Y,[X|R]) :- passagem(X,Z), rota(Z,Y,R).

% comandos para o agente

ande(L) :- 
   pos(agente,L), !.
ande(L) :- 
   retract(pos(agente,P)), 
   assert(pos(agente,L)), 
   length(R,_), 
   rota(P,L,R), 
   siga(R), !.

pegue(O) :- 
   seg(O), !.
pegue(O) :-
   pos(O,P), 
   ande(P),         
   retract(pos(O,_)), 
   assert(seg(O)),
   get(@a,position,X),
   obj(O,No,_),
   send(No,move,X), !. 

solte(O) :- 
   not(seg(O)), !.
solte(O) :- 
   pos(agente,P), 
   not(member(P,[5,6])),    
   retract(seg(O)), 
   assert(pos(O,P)), 
   get(@a,position,point(X,Y)),
   obj(O,No,Yo), X1 is X-20, Y1 is Y+Yo,
   send(No,move,point(X1,Y1)), !. 

siga([]).
siga([S|R]) :- mova(S), send(@t,delay), siga(R).

mova(S) :- 
   sala(S,X,Y), 
   forall(seg(O),(obj(O,No,_),send(No,move,point(X,Y)))),
   send(@a,move,point(X,Y)).
	 	
sala(1,  45,  47).
sala(2, 140,  47).
sala(3, 235,  47).
sala(4,  45, 142).
sala(5, 140, 142).
sala(6, 235, 142).
sala(7,  45, 237).
sala(8, 140, 237).
sala(9, 235, 237).

obj(1, @o1, -20).
obj(2, @o2,   0).
obj(3, @o3, +20).







