% Lab5
:- use_module(library(clpfd)).

% Containers
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

% Stacking
on(a,d).
on(b,c).
on(c,d).

% List all containers
containers(Containers) :-
    findall([I,P,D], container(I,P,D),Containers).

% Calculates how many workers we need at max.
max_workers([],Sum,Sum).
max_workers([[_,P,_d]|Tail],Prev,Sum) :-
    NewPrev is Prev+P,
    max_workers(Tail,NewPrev,Sum).

% Cost calculation
cost(NumWorkers,Duration,Cost) :-
    Cost = NumWorkers * Duration.

% duration(NumWorkers,Containers,Duration)
% calculates minimum duration required for stacking
%duration(NumWorkers, Containers, Duration) :-
        
% Constraint for start time
start_cons(Id1,S1,E1,Id2,S2,E2) :-
    on(Id1,Id2), S2 #>= E1.

start_cons(Id1,S1,E1,Id2,S2,E2) :-
    on(Id2,Id1), S1 #>= E2.

top_layer(Id,Containers) :-
    not(on(X,Id)).

top_layer(Id,Containers) :-
    findall(X,(on(X,Id),member([X,_,_,1],Containers)),Above).
    
    
% All constraints

time_cons(Id1,S1,D1,E1,Id2,S2,D2,E2) :-
    on(Id1,Id2), E1 #= S1+D1, 
    S2 #>= E1, E2 #= S2+D2.

time_cons(Id1,S1,D1,E1,Id2,S2,D2,E2) :-
    on(Id2,Id1), E2 #= S2+D2, 
    S1 #>= E2, E1 #= S1+D1. 
    
solve(Workers) :-
    containers(Containers), max_workers(Containers,0,MaxWorkers),
    Workers in 1..MaxWorkers.

    
