% Lab 1 TDDD08

beautiful(ulrika).
beautiful(nisse).
beautiful(peter).
rich(bettan).
rich(nisse).
strong(bettan).
strong(peter).
strong(bosse).
kind(bosse).

man(bosse).
man(nisse).
man(peter).
woman(ulrika).
woman(bettan).

% Find out if X likes Y
likes(X, Y) :- man(X),woman(Y),beautiful(Y).


likes(ulrika,Y) :- man(Y), rich(Y), kind(Y),likes(Y, ulrika).

likes(ulrika,Y) :- man(Y), beautiful(Y), strong(Y), likes(Y, ulrika).

likes(nisse,Y) :- woman(Y), likes(Y, nisse).


happy(X) :- rich(X).
happy(X) :- man(X), woman(Y), likes(X,Y), likes(Y,X). 
happy(X) :- man(Y), woman(X), likes(X,Y), likes(Y,X).



/*
Test queries:

Who is happy?:---------
  
?- happy(X).

X = bettan ;
X = nisse ;
X = peter ;
X = ulrika ;
-----------------------

Who likes who?:--------
?- likes(X,Y)

X = bosse,
Y = ulrika ;
X = nisse,
Y = ulrika ;
X = peter,
Y = ulrika ;
X = ulrika,
Y = peter ;
----------------------

How many persons like Ulrika?:--

?- findall(X,likes(X,ulrika),Z), length(Z,L).

Z = [bosse, nisse, peter],
L = 3.
--------------------------------

*/ 
