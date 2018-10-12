% Lab4
:- set_prolog_flag(answer_write_options,[max_depth(0)]).
% Move one of each to right
children([[Ml,Cl],Bs,[Mr,Cr]], [[Mla,Cla],Bsa,[Mra,Cra]]) :-
    Mla is Ml-1,
    Cla is Cl-1,
    Mra is Mr+1,
    Cra is Cr+1,
    Mla>=0, Cla>=0,
    Bs=0, Bsa=1,
    check_state([[Mla,Cla],Bsa,[Mra,Cra]]).

% Move 2 M to right
children([[Ml,Cl],Bs,[Mr,Cr]], [[Mla,Cl],Bsa,[Mra,Cr]]) :-
    Mla is Ml-2,
    Mra is Mr+2,
    Mla>=0,
    Bs=0,Bsa=1,
    check_state([[Mla,Cl],Bsa,[Mra,Cr]]).
% Move 2 C to right
children([[Ml,Cl],Bs,[Mr,Cr]], [[Ml,Cla],Bsa,[Mr,Cra]]) :-
    Cla is Cl-2,
    Cra is Cr+2,
    Cla>=0,
    Bs=0,Bsa=1,
    check_state([[Ml,Cla],Bsa,[Mr,Cra]]).
% Move 1 M to right
children([[Ml,Cl],Bs,[Mr,Cr]], [[Mla,Cl],Bsa,[Mra,Cr]]) :-
    Mla is Ml-1,
    Mra is Mr+1,
    Mla>=0,
    Bs=0,Bsa=1,
    check_state([[Mla,Cl],Bsa,[Mra,Cr]]).
% Move 1 C to right
children([[Ml,Cl],Bs,[Mr,Cr]], [[Ml,Cla],Bsa,[Mr,Cra]]) :-
    Cla is Cl-1,
    Cra is Cr+1,
    Cla>=0,
    Bs=0,Bsa=1,
    check_state([[Ml,Cla],Bsa,[Mr,Cra]]).
% ------------------------------------------------------------
% Move one of each to left
children([[Ml,Cl],Bs,[Mr,Cr]], [[Mla,Cla],Bsa,[Mra,Cra]]) :-
    Mla is Ml+1,
    Cla is Cl+1,
    Mra is Mr-1,
    Cra is Cr-1,
    Mra>=0, Cra>=0,
    Bs=1, Bsa=0,
    check_state([[Mla,Cla],Bsa,[Mra,Cra]]).

% Move 2 M to left
children([[Ml,Cl],Bs,[Mr,Cr]], [[Mla,Cl],Bsa,[Mra,Cr]]) :-
    Mla is Ml+2,
    Mra is Mr-2,
    Mra>=0,
    Bs=1,Bsa=0,
    check_state([[Mla,Cl],Bsa,[Mra,Cr]]).
% Move 2 C to left
children([[Ml,Cl],Bs,[Mr,Cr]], [[Ml,Cla],Bsa,[Mr,Cra]]) :-
    Cla is Cl+2,
    Cra is Cr-2,
    Cra>=0,
    Bs=1,Bsa=0,
    check_state([[Ml,Cla],Bsa,[Mr,Cra]]).
% Move 1 M to left
children([[Ml,Cl],Bs,[Mr,Cr]], [[Mla,Cl],Bsa,[Mra,Cr]]) :-
    Mla is Ml+1,
    Mra is Mr-1,
    Mra>=0,
    Bs=1,Bsa=0,
    check_state([[Mla,Cl],Bsa,[Mra,Cr]]).
% Move 1 C to left
children([[Ml,Cl],Bs,[Mr,Cr]], [[Ml,Cla],Bsa,[Mr,Cra]]) :-
    Cla is Cl+1,
    Cra is Cr-1,
    Cra>=0,
    Bs=1,Bsa=0,
    check_state([[Ml,Cla],Bsa,[Mr,Cra]]).
% ---------------------------------------------------------
% Check if number of C is greater than number of M
check_state([[0,_],_,[Mr,Cr]]) :-
    Mr>=Cr.
check_state([[Ml,Cl],_,[0,_]]) :-
    Ml>=Cl.
check_state([[Ml,Cl],_,[Mr,Cr]]):-
    Ml >= Cl, Mr >= Cr.
%-----------------------------------------------------------

% Breadth first search
bfs(In, Goal) :-
    bfs_help([In],[],Goal).        

% bfs(Queue,Visited,Goal)
% In each step: check if first element of Queue is Goal,
% if not, push all children of first element that have not
% already been processed to back of Queue and continue with
% rest of Queue.
bfs_help([Goal|_],_,Goal):-
    print('Found Goal: '),print(Goal).

bfs_help([Q1|Tail],Visited,Goal) :- 
    print(Q1),print('---->'),
    findall(X, (children(Q1,X),check_visited(Visited,X)),Tmp),
    append(Tail,Tmp,New_Queue), 
    append(Visited,[Q1],New_Visited),
    bfs_help(New_Queue,New_Visited,Goal).

% Depth first search

dfs(In,Goal) :-
    dfs_help(In,[],Goal). 

dfs_help(Goal,Visited,Goal) :-
    append(Visited,[Goal],New),
    print_elements(New).

dfs_help(In,Visited,Goal) :-
    check_visited(Visited,In),
    append(Visited,[In],New_Visited),
    children(In,Child),
    dfs_help(Child,New_Visited,Goal).
    
% Check if State has already been visited
check_visited([],_).
check_visited([HeadState|Rest],State) :-
    not(HeadState = State),
    check_visited(Rest,State).

% Printing the states
print_elements([]).
print_elements([X]) :-
    print(X).
print_elements([H|T]) :-
    not(T = []),
    print(H),
    print('-->'),
    print_elements(T).

% Example for depth-first-search (Prints solutions as possible sequences of states to reach goal):
% ?- dfs([[3,3],0,[0,0]],[[0,0],1,[3,3]]).
% [[3,3],0,[0,0]]-->[[2,2],1,[1,1]]-->[[3,2],0,[0,1]]-->[[3,0],1,[0,3]]-->[[3,1],0,[0,2]]-->[[1,1],1,[2,2]]-->[[2,2],0,[1,1]]-->[[0,2],1,[3,1]]-->[[0,3],0,[3,0]]-->[[0,1],1,[3,2]]-->[[1,1],0,[2,2]]-->[[0,0],1,[3,3]]
%
% [[3,3],0,[0,0]]-->[[2,2],1,[1,1]]-->[[3,2],0,[0,1]]-->[[3,0],1,[0,3]]-->[[3,1],0,[0,2]]-->[[1,1],1,[2,2]]-->[[2,2],0,[1,1]]-->[[0,2],1,[3,1]]-->[[0,3],0,[3,0]]-->[[0,1],1,[3,2]]-->[[1,1],0,[2,2]]-->[[0,0],1,[3,3]]-->[[0,2],0,[3,1]]-->[[0,0],1,[3,3]]
%
% [[3,3],0,[0,0]]-->[[2,2],1,[1,1]]-->[[3,2],0,[0,1]]-->[[3,0],1,[0,3]]-->[[3,1],0,[0,2]]-->[[1,1],1,[2,2]]-->[[2,2],0,[1,1]]-->[[0,2],1,[3,1]]-->[[0,3],0,[3,0]]-->[[0,1],1,[3,2]]-->[[1,1],0,[2,2]]-->[[0,0],1,[3,3]]-->[[0,2],0,[3,1]]-->[[0,0],1,[3,3]]
% 
% .......
% ###########################################################################

% Example breadth-first-search (shows which order states are explored in the search):
% ?- bfs([[3,3],0,[0,0]],[[0,0],1,[3,3]]). 
%[[3,3],0,[0,0]]---->[[2,2],1,[1,1]]---->[[3,1],1,[0,2]]---->[[3,2],1,[0,1]]---->[[3,2],0,[0,1]]---->[[3,2],0,[0,1]]---->[[3,0],1,[0,3]]---->[[3,0],1,[0,3]]---->[[3,1],0,[0,2]]---->[[3,1],0,[0,2]]---->[[1,1],1,[2,2]]---->[[1,1],1,[2,2]]---->[[2,2],0,[1,1]]---->[[2,2],0,[1,1]]---->[[0,2],1,[3,1]]---->[[0,2],1,[3,1]]---->[[0,3],0,[3,0]]---->[[0,3],0,[3,0]]---->[[0,1],1,[3,2]]---->[[0,1],1,[3,2]]---->[[1,1],0,[2,2]]---->[[0,2],0,[3,1]]---->[[1,1],0,[2,2]]---->[[0,2],0,[3,1]]---->'Found Goal: '[[0,0],1,[3,3]]
