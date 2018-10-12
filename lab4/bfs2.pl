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
    bfs_help([In],[],[],Goal).        

bfs_help([Goal|_],_,Goal) :-
    print(Goal).

bfs_help([Q1|Tail],Visited,Paths,Goal) :- 
    findall(X, (children(Q1,X),check_visited(Visited,X)),Tmp),
    append(Tail,Tmp,New_Queue),
    print(Q1),print('--->'), 
    append(Visited,[Q1],New_Visited),
    bfs_help(New_Queue,New_Visited,Goal).

% For keeping track of path for printing purposes

% expand_path(Current,Children,Path,Res)
expand_path(_,[],_,[]).

expand_path(Current,[C1|T1],Paths,[Res1|T2]) :-
    expand_one(Current,C1,Paths,[Res1]),
    expand_path(Current,T1,Paths,T2).

% expand_one(Current,Child,Paths,Res)
expand_one(_,_,[],[]).

expand_one(Current,Child,[[Current|T1]|T2],[[Child,Current|T1]|T3]):-
    %append([Child,Current|T1],Res,NewRes),
    expand_one(Current,Child,T2,T3).
        
expand_one(Current,Child,[[H|T1]|T2],[[H|T1]|T3]) :-
    not(Current = H),
    expand_one(Current,Child,T2,T3). 


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

