% 2.1 Sorting

% Check if list of numbers is sorted in ascending order
issorted([]).
issorted([_]).
issorted([X,Y|T]) :- X =< Y , issorted([Y|T]). 

% Find min elem in list
min_elem([M], M).
min_elem([X, Y|T], M) :- X >= Y, min_elem([Y|T],M).
min_elem([X, Y|T], M) :- Y >= X, min_elem([X|T],M).

% remove element form list
rm_elem(Elem, [Elem|T], T).
rm_elem(Elem, [Head|T1], [Head|T2]) :- rm_elem(Elem, T1, T2). 

% ssort/2, selection sort 
ssort([],[]).
ssort([H|T],[M|R]) :- 
    min_elem([H|T],M),
    rm_elem(M, [H|T], N),
    ssort(N,R).
