% Facts representing a graph
connected(a, b).
connected(a, c).
connected(b, c).
connected(c, d).
connected(d, h).
connected(d, f).
connected(c, e).
connected(e, f).
connected(e, g).
connected(f, g).


% Appending lists
app([],L,L).
app([H|T], L, [H|R]) :- app(T,L,R).

% Checks for a path between two nodes
path(X, Y) :- connected(X, Y).
path(X, Y) :- connected(X, Z), path(Z, Y).

% Checks for a path and saves the path
path(X, Y, [X,Y]) :- connected(X,Y).
path(X, Y, [X|T]) :- connected(X,Z), path(Z,Y,T).

% Checks for a path and saves the length of the path
npath(X,Y,L) :- path(X,Y,[X|T]), length(T,L).
