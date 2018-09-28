% 2.4 Set Relations

% set_union/3 computes the union between two sets

set_union([],[],[]).
set_union(S,[],S).
set_union([],S,S).
set_union([H1|T1], [H2|T2], [H1|TR]) :-
    H1 @< H2,
    set_union(T1, [H2|T2], TR).

set_union([H1|T1], [H2|T2], [H2|TR]) :-
    H2 @< H1,
    set_union([H1|T1], T2, TR).

set_union([H1|T1], [H1|T2], [H1|TR]) :-
    set_union(T1,T2,TR).


% set_intersection/3 computes the intersection between 2 sets

set_intersect([],_,[]).
set_intersect(_,[],[]).

set_intersect([H|T1], [H|T2], [H|TR]) :-
    set_intersect(T1, T2, TR).

set_intersect([H1|T1], [H2|T2], Res) :-
    H1 @< H2,
    set_intersect(T1, [H2|T2], Res).

set_intersect([H1|T1], [H2|T2], Res) :-
    H2 @< H1,
    set_intersect([H1|T1], T2, Res).
% is_set
is_set([],true).
is_set([_],true).
is_set([H1,H2|T], Res) :-
    H1 @< H2,
    is_set([H2|T], Res).


% powerset.... i dunno man
p_help([],[[]]).
p_help([H|T], [HR|TR]) :-
    set_union(T2, T, T),
    is_set(T2, true),
    %length([H|T], L2),
    %length([H|T2], L1),
    %L2 >= L1, 
    set_intersect([H|T2],[H|T],X),
    p_help(T, TR).
