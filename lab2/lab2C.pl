% Abstract Machine

id(I).
% num(number).
% Makes sure that number is an interger or double.
num(N) :- number(N).

% execute(Start-Environment, Instruction, End-Environment)
% execute starts with a data environment (Start-Environment) runs the Instruction and updates the environment (End-Environment). 
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

    
% eval arithmetic(Environment, Arithmetic-Expression, Result)
% Calculates the Arithmetic-Expression and saves the result in Result. 
% If variables is used the value is fetched from Environment. 
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

% eval_bool(Environment, Expression, Result)
% Gets variable value from Environment if needed and calculate the boolean result of the Expresson.
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

% update_env(Start-Environment, Identifier, Replacement, Final-Environment)
% Final-Environment contains the data from Start-Environment with the new Identifier.
% If the Identifier already exists in Start-Environment, its value is now replaced with Replacement.
update_env([(I,_)|Tail], I, Replacement, [(I, Replacement)|Tail]).
update_env([H|T], I, Replacement, [H|T2]) :- update_env(T, I, Replacement, T2).
update_env([], I, Replacement, [(I,Replacement)]).

% Körexempel:
%
% ?- execute([(x,3)],seq(set(y,num(1)),while(id(x) > num(1),seq(set(y, id(y) * id(x)),set(x, id(x) - num(1))))), Env).
% Env = [(x, 1),  (y, 6)] ;
