% 2.4 Set Relations

% set_union(Set1, Set2, Result)
% Set1 and Set2 is in ascending order.
% Results contains every element from Set1 and Set2 once, and in ascending order.
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

% set_intersection(Set1, Set2, Result)
% Set1 and Set2 is in ascending order.
% Result contains those elements that exists in both Set1 and Set2. 
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

% p_set(Set, Result)
% Result contains all Sets that unified with Set, still is Set.
% In other words, every combination of the elements in Set in ascending order.
p_set(Set, Res) :-
    findall(X, set_union(Set, X, Set), Res).

