% Lab4

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
bfs(Goal,Goal).

bfs(In,Goal) :-
    findall(X,children(In,X),
    bfs(Child,Goal). 



