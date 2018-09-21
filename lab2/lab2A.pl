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

%---- Partition list into smaller or bigger than element -----
partition([], _, [], []). % Base condition, if the list is empty, we get 2 empty lists.

partition([Head|Tail], N, [Head|Left], Right) :-
    Head =< N,
    partition(Tail, N, Left, Right).

partition([Head|Tail], N, Left, [Head|Right]) :-
    Head > N,
    partition(Tail, N, Left, Right).


%------ qsort/2, Quicksort ------------
qsort([],[]).
qsort([Head|Tail], Ls) :-
    partition(Tail, Head, Left, Right),% Partition into 2 lists with smaller and bigger elements.
    qsort(Left, Lls), % Quicksort left side.
    qsort(Right, Lrs), % Quicksort right side.
    append(Lls, [Head|Lrs], Ls). % Concatinate both List partitions. And add pivot-element "head" again.
