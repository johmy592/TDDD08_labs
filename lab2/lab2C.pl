% Abstract Machine

id(I).
num(N) :- number(N).

skip.

% Execute
execute(Env0, skip, Env0).
execute(Env0, set(I, Val), Env) :-   
    once(update_env(Env0, I, Val, Env)).
      

    
% Arithmetic operations
eval_arithmetic(Env, id(I), Val) :- member((I,Val), Env).
eval_arithmetic(_, num(N), N).

eval_arithmetic(Env, X1 + Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    Res is X2 + Y2.

eval_arithmetic(Env, X1 - Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    Res is X2 - Y2.

eval_arithmetic(Env, X1 * Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    Res is X2 * Y2.

eval_arithmetic(Env, X1 / Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    Res is X2 / Y2.

% Boolean evaluation
eval_bool(_, tt, tt).
eval_bool(_, ff, ff).

eval_bool(Env, X1 > Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    Res = (X2 > Y2).
    

% update_env(Env0, I, Replacement, Env)
update_env([(I,_)|Tail], I, Replacement, [(I, Replacement)|Tail]).
update_env([H|T], I, Replacement, [H|T2]) :- update_env(T, I, Replacement, T2).
update_env([], I, Replacement, [(I,Replacement)]).
