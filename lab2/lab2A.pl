% 2.1 Sorting

% issorted(List)
% Check if List is sorted in ascending order.
issorted([]).
issorted([_]).
issorted([X,Y|T]) :- X =< Y , issorted([Y|T]). 

% min_elem(List, Element)
% Finds the smallest element in the list M.
min_elem([M], M).
min_elem([X, Y|T], M) :- X >= Y, min_elem([Y|T],M).
min_elem([X, Y|T], M) :- Y >= X, min_elem([X|T],M).

% rm_elem(Element, List, Result)
% Result is List without Element.
rm_elem(Elem, [Elem|T], T).
rm_elem(Elem, [Head|T1], [Head|T2]) :- rm_elem(Elem, T1, T2). 

% ssort(List, Result)
% Result is List but sorted using selection sort.
% It finds the smallest element from List, makes sure its the head of result and repeats using the rest of List (tail).
ssort([],[]).
ssort([H|T],[M|R]) :- 
    min_elem([H|T],M),
    rm_elem(M, [H|T], N),
    ssort(N,R).

% partition(List, Pivot-Element, Less, Great)
% Partitions List into two lists Less and Great depending on if the elements are greater or less than Pivot-Element.
partition([], _, [], []).
partition([Head|Tail], N, [Head|Left], Right) :-
    Head =< N,
    partition(Tail, N, Left, Right).

partition([Head|Tail], N, Left, [Head|Right]) :-
    Head > N,
    partition(Tail, N, Left, Right).


% qsort(List, Result)
% Result is List but sorted using quick sort algorithm.
% Partitions List into 2 that is less or larger than a pivot-element (usually head of list).
% Runs quicksort on both partitions and then appends both partitions back to a sorted list.
qsort([],[]).
qsort([Head|Tail], Ls) :-
    partition(Tail, Head, Left, Right),
    qsort(Left, Lls),
    qsort(Right, Lrs),
    append(Lls, [Head|Lrs], Ls).
