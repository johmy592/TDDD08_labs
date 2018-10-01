% 2.4 Set Relations

% set_union/3 computes the union between two sets

set_union([],[],[]).
set_union([H|T],[],[H|T]).
set_union([],[H|T],[H|T]).

set_union([H1|T1], [H1|T2], [H1|TR]) :-
    set_union(T1,T2,TR).

set_union([H1|T1], [H2|T2], [H2|TR]) :-
    set_union([H1|T1], T2, TR),
    H2 @< H1.

set_union([H1|T1], [H2|T2], [H1|TR]) :-
    set_union(T1, [H2|T2], TR),
    H1 @< H2.

% set_intersection/3 computes the intersection between 2 sets

set_intersect([],[],[]).
set_intersect([],[_H|_T],[]).
set_intersect([_H|_T],[],[]).

set_intersect([H|T1], [H|T2], [H|TR]) :-
    set_intersect(T1, T2, TR).

set_intersect([H1|T1], [H2|T2], Res) :-
    set_intersect(T1, [H2|T2], Res),
    H1 @< H2.

set_intersect([H1|T1], [H2|T2], Res) :-
    set_intersect([H1|T1], T2, Res),
    H2 @< H1.

% powerset/2
p_set(Set, Res) :-
    findall(X, set_union(Set, X, Set),Res).

