% Lab 1B

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


% path(X, Y)
% There is a path between node X and Y if X and Y is connected
% or if X and Y has connected nodes between them.
path(X, Y) :- connected(X, Y).
path(X, Y) :- connected(X, Z), path(Z, Y).

% path(X, Y, Path)
% Same as path(X, Y)/2, where Path is the list of nodes in the path.
path(X, Y, [X,Y]) :- connected(X,Y).
path(X, Y, [X|T]) :- connected(X,Z), path(Z,Y,T).

% npath(X, Y, L)
% X and Y is two nodes in a graph where L is the length of the path between them.
npath(X,Y,L) :- path(X,Y,[X|T]), length(T,L).
