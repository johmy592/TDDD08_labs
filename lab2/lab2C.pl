% Abstract Machine

id(I).
num(N) :- number(N).

skip.

% Execute
execute(Env0, skip, Env0).
execute(Env0, set(I, Val), Env) :-   
    eval_arithmetic(Env0, Val, Res),
    once(update_env(Env0, I, Res, Env)).
      
execute(Env0, if(B, TC, _), Env) :-
    eval_bool(Env0, B, true),
    execute(Env0, TC, Env).

execute(Env0, if(B, _, FC), Env) :-
    eval_bool(Env0, B, false),
    execute(Env0, FC, Env).

execute(Env0, while(B, TC), Env) :-
    eval_bool(Env0, B, true),
    execute(Env0, TC, I_Env),
    execute(I_Env, while(B, TC), Env).

execute(Env0, while(B, _), Env0) :-
    eval_bool(Env0, B, false).
    

execute(Env0, seq(C1, C2), Env) :-
    execute(Env0, C1, I_Env),
    execute(I_Env, C2, Env).

    
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
eval_bool(_, tt, true).
eval_bool(_, ff, false).

eval_bool(Env, X1 > Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    (X2 > Y2 -> 
    Res = true ; Res = false).   

eval_bool(Env, X1 < Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    (X2 < Y2 -> 
    Res = true ; Res = false).

eval_bool(Env, X1 == Y1, Res) :-
    eval_arithmetic(Env, X1, X2),
    eval_arithmetic(Env, Y1, Y2),
    (X2 =:= Y2 -> 
    Res = true ; Res = false).

% update_env(Env0, I, Replacement, Env)
update_env([(I,_)|Tail], I, Replacement, [(I, Replacement)|Tail]).
update_env([H|T], I, Replacement, [H|T2]) :- update_env(T, I, Replacement, T2).
update_env([], I, Replacement, [(I,Replacement)]).
