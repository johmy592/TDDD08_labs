:- use_module(library(clpfd)).

container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

on(a,d).
on(b,c).
on(c,d).

% S_i denotes the start time, 
% D_i the positive duration, 
% E_i the end time, 
% C_i the non-negative resource consumption,
% T_i the task identifier.
cost(Duration, Workers, Res) :- 
    Res is (Duration * Workers).

task_something(List) :-
    findall([ID, Workers, Duration, _Start,_End], container(ID,Workers, Duration), List).
    
allowed_to_start(ID,Start) :- 
    not(on(_,ID)).

allowed_to_start(ID, Start) :- 
    on(_, ID),
    findall(On,(on(On, ID), member([On,_,_,_,End], List), Start #>= End), On_Tops).

min_workers(Res) :- 
    findall(Workers, container(ID,Workers,Duration), List),
    max_list(List, Res).

max_workers(Res) :-
    findall(Workers, container(ID,Workers,Duration), List),
    sumlist(List, Res).

time_contraint(S1,D1,E1) :-
    E1 #= S1 + D1.

worker_constraint(W, Occupied_w, Tot_w) :-
    W #=< Tot_w - Occupied_w.


containers(Containers) :-
    findall([I,P,D], container(I,P,D),Containers).

split_lists([],[],[],[]).

split_lists([[I,P,D]|Tail],[I|IT],[P|PT], [D|DT]) :-
    split_lists(Tail,IT,PT,DT).

%schedule2(S).
schedule2(Ss) :-
    containers(Containers),
    split_lists(Containers,Ids,Workers,Durations),
    length(Ids,N),
    length(Ss,N),
    length(Es,N),
    tasks(Ids,Workers,Durations,Ss,Es,Tasks),
    %sumlist(Workers,MaxWorkers),
    %domain(NumWorkers, 1, MaxWorkers),
    %cumulative(Tasks,[limit(5)]).   
    domain(Ss, 1, 100),
    domain(Es, 1, 100),
    %domain([End], 1, 100),
    %maximum(End, Es),
    cumulative(Tasks, [limit(13)]),
    %append(Ss, [End], Vars),
    %labeling([minimize(End)], Vars). % label End last

tasks([],[],[],[],[],[]).
tasks([Id|IT],[W|WT],[D|DT],[S|ST],[E|ET],[task(S,D,E,W,0)|Tail]) :-
    tasks(IT,WT,DT,ST,ET,Tail).
    

schedule(Ss, End):-
    Ss = [S1,S2,S3,S4,S5,S6,S7],
    Es = [E1,E2,E3,E4,E5,E6,E7],
    Tasks = [task(S1,16,E1, 2,0),
             task(S2, 6,E2, 9,0),
             task(S3,13,E3, 3,0),
             task(S4, 7,E4, 7,0),
             task(S5, 5,E5,10,0),
             task(S6,18,E6, 1,0),
             task(S7, 4,E7,11,0)],
    domain(Ss, 1, 30),
    domain(Es, 1, 50),
    domain([End], 1, 50),
    maximum(Es, End),
    cumulative(Tasks, [limit(13)]),
    append(Ss, [End], Vars),
    labeling([minimize(End)], Vars). % label End last
