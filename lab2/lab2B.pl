% Lab 2.2 Search Strategies

% middle(X,Xs)
% X is the middle element in the Xs

middle(X, [X]).
middle(X, [First|Xs]) :-
    append(Middle, [Last], Xs),
    middle(X, Middle).

%middle(X, [X]).
%middle(X, [First|Xs]) :-
%    append(Middle, [Last], Xs),
%    middle(X, Middle).
%
% ?- middle(X, [a,b,c]).
% X = b ;
% false.

% 1 ?- middle(a, X).
% X = [a] ;
% X = [_3412, a, _3418] ;
% X = [_3412, _3424, a, _3448, _3418] ;
% X = [_3412, _3424, _3436, a, _3460, _3472, _3418] 
%----------------------------------

% middle(X, [X]).
% middle(X, [First|Xs]) :-
%    middle(X, Middle),
%    append(Middle, [Last], Xs).
%
%1 ?- middle(X, [a,b,c]).
%X = b ;
%; 
%;
%;.......
% 
% 2 ?- middle(a,X).
% X = [a] ;
% X = [_854, a, _866] ;
% X = [_854, _860, a, _872, _884] ;
% 
%------------------------------------

% middle(X, [First|Xs]) :-
%    append(Middle, [Last], Xs),
%    middle(X, Middle).
% middle(X, [X]). 
% 
% 1 ?- middle(X, [a,b,c]).
% X = b ;
% false.

% 2 ?- middle(a,X).
% X = [_4076, a, _4082] ;
% X = [_4076, _4088, a, _4112, _4082] ;
% X = [_4076, _4088, _4100, a, _4124, _4136, _4082] 

%--------------------------------------------------

% middle(X, [First|Xs]) :-
%     middle(X, Middle),
%     append(Middle, [Last], Xs).
% middle(X, [X]).

% ?- middle(X,[a,b,c]).
% inf. loop

% ?- middle(a, X).
% inf. loop
