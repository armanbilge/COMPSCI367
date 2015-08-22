neighbor(State1, State2) :-
    nth0(Index1, State1, 0),
    nth0(Index2, State2, 0),
    nth0(Index2, State1, X),
    nth0(Index1, State2, X),
    I1 is Index1 div 3,
    I2 is Index2 div 3,
    J1 is Index1 mod 3,
    J2 is Index2 mod 3,
    abs(I1 - I2) + abs(J1 - J2) =:= 1.

neighbors(State, Neighbors) :-
    findall(Neighbor, neighbor(State, Neighbor), Neighbors).

sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, Rest),
    Sum is H + Rest.

part_h(State, HeuristicValue) :-
    is_goal(GoalState),
    nth0(Index1, State, X),
    nth0(Index2, GoalState, X),
    I1 is Index1 div 3,
    I2 is Index2 div 3,
    J1 is Index1 mod 3,
    J2 is Index2 mod 3,
    HeuristicValue is abs(I1 - I2) + abs(J1 - J2).

h(State, HeuristicValue) :-
    bagof(H, part_h(State, H), Hs),
    sum_list(Hs, HeuristicValue).