% Lets try again LUL
:- use_module(library(clpfd)).
% ----------------------------------------
% Containers
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

% Stacking
on(a,d).
on(b,c).
on(c,d).

containers(Containers) :-
    findall([I,P,D], container(I,P,D),Containers).

split_lists([],[],[],[]).

split_lists([[I,P,D]|Tail],[I|IT],[P|PT], [D|DT]) :-
    split_lists(Tail,IT,PT,DT).
%-----------------------------------------
schedule(Ss, End) :-
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
        maximum(End, Es),
        cumulative(Tasks, [limit(13)]),
        append(Ss, [End], Vars),
        labeling([minimize(End)], Vars). % label End last

schedule2(Ss,End) :-
    containers(Containers),
    split_lists(Containers,Ids,Workers,Durations), 
    length(Ids,N),
    length(Ss,N),
    length(Es,N),
    tasks(Ids,Workers,Durations,Ss,Es,Tasks),
    sumlist(Workers,MaxWorkers),
    NumWorkers in 1..MaxWorkers,
    %cumulative(Tasks,[limit(5)]).   
    Ss ins 0..10, Es ins 0..10,
    
    End in 1..10,
    max_list(Es, End),
    cumulative(Tasks, [limit(13)]),
    append(Ss, [End], Vars),
    labeling([minimize(End)], Vars). % label End last



% tasks(Ids,Workers,Durations,Ss,Es,Tasks)
tasks([],[],[],[],[],[]).
tasks([Id|IT],[W|WT],[D|DT],[S|ST],[E|ET],[task(S,D,E,W,0)|Tail]) :-
    tasks(IT,WT,DT,ST,ET,Tail).

