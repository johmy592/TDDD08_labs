:- use_module(library(clpfd)).

% container(Identifier,Workers,Time)
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

% on(ContainerA,ContainerB) 
on(a,d).
on(b,c).
on(c,d).

/* 
Optimize(NumWorkers,TimeWorked,Cost,Start_times). 
calculates optimal NumWorkers to unload all containers
by minimizing the Cost=NumWorkers*TimeWorked.
*/
optimize(NumWorkers, TimeWorked, Cost, Start_times):-
    containers(Containers),
    split_lists(Containers,Ids,Workers,Durations),
    
    % Get lists of start and end times for every Id
    length(Ids,N),
    length(Start_times,N),
    length(End_times,N),

    make_tasks(Workers,Durations,Start_times,End_times,Tasks),
    
    % Sums all durations to get an upper limit on start times,
    % end times and total time worked
    list_sum(Durations, MaxDuration),
    domain(Start_times, 0, MaxDuration),
    domain(End_times, 0, MaxDuration), 
    domain([TimeWorked],1, MaxDuration),

    % Sums workers required for all containers to get an upper limit
    list_sum(Workers, MaxWorkers),
    domain([NumWorkers], 1, MaxWorkers),

    maximum(TimeWorked, End_times),
    set_cons(Start_times,End_times,Ids),

    cumulative(Tasks, [limit(NumWorkers)]),
    Cost #= NumWorkers*TimeWorked,
    append(Start_times,[Cost],Vars),
    labeling([minimize(Cost)], Vars).

% containers(Containers). Containers is a list of all container data.
containers(Containers) :-
    findall([I,P,D], container(I,P,D),Containers).

/* 
split_lists(Containers,Ids,Workers,Durations). 
Splits all container data into separate lists.
*/
split_lists([],[],[],[]).
split_lists([[I,W,D]|Tail],[I|IT],[W|WT], [D|DT]) :-
    split_lists(Tail,IT,WT,DT).
% list_sum(List,Sum). Sum is the sum of all items in List
list_sum([X], X).
list_sum([Num1,Num2 | Tail], Sum) :-
    New is Num1 + Num2,
    list_sum([New|Tail], Sum).

/* 
make_tasks(Ids,Workers,Durations,Starttimes,Endtimes,Tasks).
uses the container data to create tasks to be used later in cumulative
*/
make_tasks([],[],[],[],[]).
make_tasks([W|WT],[D|DT],[S|ST],[E|ET],[task(S,D,E,W,0)|Tail]) :-
    make_tasks(WT,DT,ST,ET,Tail).

/* 
start_cons(Start1,Start2,End1,End2,Id1,Id2).
sets constraints on start times if one container is on top of another.
*/
start_cons(Start1, Start2, End1, End2, Id1, Id2):- on(Id1, Id2), Start2 #>= End1.
start_cons(Start1, Start2, End1, End2, Id1, Id2):- on(Id2, Id1), Start1 #>= End2.
start_cons(Start1, Start2, End1, End2, Id1, Id2):- \+(on(Id1,Id2)), \+(on(Id2,Id1)).

/*
set_cons(Starttimes,Endtimes,Ids).
Goes through all pairs of containers to set apropriate start time constraints.
Uses inner_loop(Start,End,Id,Start_tail,End_tail,Id_tail). inner_loop takes
the current head of the list and sets apropriate constraints with all elements
later in the list.  
*/
set_cons([],[],[]).
set_cons([Start_head|Start_tail], [End_head|End_tail], [Id_head|Id_tail]) :- 
    inner_loop(Start_head, End_head, Id_head, Start_tail, End_tail, Id_tail),
    set_cons(Start_tail, End_tail, Id_tail).

inner_loop(_,_,_,[],[],[]).
inner_loop(Start, End, Id, [Start_head|Start_tail], [End_head|End_tail], [Id_head|Id_tail]) :-
    start_cons(Start, Start_head, End, End_head, Id, Id_head),
    inner_loop(Start, End, Id, Start_tail, End_tail, Id_tail).

/*
Examples:
Setup:
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).
 
on(a,d).
on(b,c).
on(c,d).

?- optimize(W,T,C,Start_times).
W = 4,
T = 4,
C = 16,
Start_times = [1,0,1,3] ? ;

Setup:
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).
container(e,2,1).
 
on(a,d).
on(b,c).
on(c,d).
on(e,b).

?- optimize(W,T,C,Start_times).
W = 4,
T = 5,
C = 20,
Start_times = [2,1,2,4,0] ?

setup:
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).
container(e,5,3).
 
on(a,d).
on(b,c).
on(c,d).


?- optimize(W,T,C,Start_times).
W = 7,
T = 5,
C = 35,
Start_times = [0,0,1,3,2]
*/
