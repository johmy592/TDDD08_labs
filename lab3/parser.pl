% Parser

:- [scanner].
:- [lab2C].

run(In, String, Out) :-
    scan(String, Tokens),
    parse(Tokens,AbstStx),
    execute(In, AbstStx,Out).

parse(Tokens, AbstrStx) :-
    program(AbstrStx, Tokens,[]). 

program(X) --> cmd(X).
program(seq(X,Y)) --> cmd(X),[;],program(Y).

cmd(skip) --> [skip].
cmd(set(I,Exp)) --> [id(I)],[:=],expression(Exp).
cmd(if(B,C1,C2)) --> [if], bool(B), [then], program(C1), [else], program(C2), [fi].
cmd(while(B,TC)) --> [while], bool(B), [do], program(TC), [od].

bool(E1 > E2) --> expression(E1), [>], expression(E2).
bool(E1 < E2) --> expression(E1), [<], expression(E2).
bool(E1 == E2) --> expression(E1), [==], expression(E2).

expression(F1 * F2) --> factor(F1), [*], expression(F2).
expression(X) --> factor(X).

factor(T1 + F) --> term(T1), [+], factor(F).
factor(T) --> term(T).

term(X) --> numerical(X);identifier(X).

identifier(id(X)) --> [id(X)],{atom(X)}.
numerical(num(X)) --> [num(X)],{number(X)}.

