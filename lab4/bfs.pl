% Breath first search

% Represent states by three tuples: (Ml,Cl), (Mb,Cb), (Mr,Cr).
state([Ml,Cl], [_,_], [Mr,Cr]) :-
    Ml >= Cl,
    Mr >= Cr.

% Check for legal state transitions
% Moving 1 C and 1 M into the boat
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Mla,Cla],[Mba,Cba],[Mr,Cr]]) :-
    Mla is Ml-1,
    Cla is Cl-1,
    Mba is Mb+1,
    Cba is Cb+1,
    (Mb+Cb) =< 2,
    (Mba+Cba) =< 2,
    (Mba+Cba) > 0,
    Mla>=0,Cla>=0.
%Moving 2 M into the boat
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Mla,Cl],[Mba,Cb],[Mr,Cr]]) :- 
    Mla is Ml-2,
    Mba is Mb+2,
    (Mb+Cb) =< 2,
    (Mba+Cb) =< 2,
    (Mba+Cb) > 0,
    Ml>=0,Cl>=0,Mb>=0,Cb>=0,Mr>=0,Cr>=0,Mla>=0,Mba>=0.
% Moving 2 C into the boat
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Ml,Cla],[Mb,Cba],[Mr,Cr]]) :-
    Cla is Cl-2,
    Cba is Cb+2,
    (Mb+Cb) =< 2,
    (Mb+Cba) =< 2,
    (Mb+Cba) > 0,
    Ml>=0,Cl>=0,Mb>=0,Cb>=0,Mr>=0,Cr>=0,Cla>=0,Cba>=0.
% Moving 1 M into the boat
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Mla,Cl],[Mba,Cb],[Mr,Cr]]) :-
    Mla is Ml-1,
    Mba is Mb+1,
    (Mba+Cb)=<2,
    (Mba+Cb) > 0.
% Moving 1 C into the boat
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Ml,Cla],[Mb,Cba],[Mr,Cr]]) :-
    Cla is Cl-1,
    Cba is Cb+1,
    (Mb+Cba) > 0,
    (Mb+Cba)=<2.
% Moving 1 M from boat to right side
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Ml,Cl],[Mba,Cb],[Mra,Cr]]) :-
    Mba is Mb-1,
    Mra is Mr+1,
    (Mba+Cb) > 0,
    Mba>=0.
% Moving 1 C from boat to right side
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Ml,Cl],[Mb,Cba],[Mr,Cra]]) :-
    Cba is Cb-1,
    Cra is Cr+1,
    (Mb+Cba) > 0,
    Cba>=0.
% Moving 1 C from boat to left
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Ml,Cla],[Mb,Cba],[Mr,Cra]]) :-
    Cba is Cb-1,
    Cla is Cl+1,
    (Mb+Cba) > 0,
    Cba>=0.
%
children([[Ml,Cl],[Mb,Cb],[Mr,Cr]], [[Ml,Cl],[Mb,Cba],[Mr,Cra]]) :-
    Cba is Cb-1,
    Cra is Cr+1,
    (Mb+Cba) > 0,
    Cba>=0.
bfs([[0,0],[0,0],[_,_]]).

%bfs([[Ml,Cl],[Mb,Cb],[Mr,Cr]]) :-
    

