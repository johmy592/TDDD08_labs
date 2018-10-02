% Lab 1 TDDD08

% Defining which persons has which characteristics
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

% likes(Person1, Person2)
% Person2 is a person that Person1 likes according to following preferences.
likes(X, Y) :- man(X),woman(Y),beautiful(Y).
likes(ulrika,Y) :- man(Y), rich(Y), kind(Y),likes(Y, ulrika).
likes(ulrika,Y) :- man(Y), beautiful(Y), strong(Y), likes(Y, ulrika).
likes(nisse,Y) :- woman(Y), likes(Y, nisse).

% happy(Person)
% True if Person is rich or the Person likes someone 
% from opposite gender and that someone likes the Person back.
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
