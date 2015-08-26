neighbor([A,0,C,D,E,F,H,I,J],[0,A,C,D,E,F,H,I,J]).
neighbor([A,B,C,D,0,F,H,I,J],[A,B,C,0,D,F,H,I,J]).
neighbor([A,B,C,D,E,F,H,0,J],[A,B,C,D,E,F,0,H,J]).
neighbor([A,B,0,D,E,F,H,I,J],[A,0,B,D,E,F,H,I,J]).
neighbor([A,B,C,D,E,0,H,I,J],[A,B,C,D,0,E,H,I,J]).
neighbor([A,B,C,D,E,F,H,I,0],[A,B,C,D,E,F,H,0,I]).
neighbor([A,B,C,0,E,F,H,I,J],[0,B,C,A,E,F,H,I,J]).
neighbor([A,B,C,D,0,F,H,I,J],[A,0,C,D,B,F,H,I,J]).
neighbor([A,B,C,D,E,0,H,I,J],[A,B,0,D,E,C,H,I,J]).
neighbor([A,B,C,D,E,F,0,I,J],[A,B,C,0,E,F,D,I,J]).
neighbor([A,B,C,D,E,F,H,0,J],[A,B,C,D,0,F,H,E,J]).
neighbor([A,B,C,D,E,F,H,I,0],[A,B,C,D,E,0,H,I,F]).
neighbor([A,0,C,D,E,F,H,I,J],[A,C,0,D,E,F,H,I,J]).
neighbor([A,B,C,D,0,F,H,I,J],[A,B,C,D,F,0,H,I,J]).
neighbor([A,B,C,D,E,F,H,0,J],[A,B,C,D,E,F,H,J,0]).
neighbor([0,B,C,D,E,F,H,I,J],[B,0,C,D,E,F,H,I,J]).
neighbor([A,B,C,0,E,F,H,I,J],[A,B,C,E,0,F,H,I,J]).
neighbor([A,B,C,D,E,F,0,I,J],[A,B,C,D,E,F,I,0,J]).
neighbor([A,B,C,0,E,F,H,I,J],[A,B,C,H,E,F,0,I,J]).
neighbor([A,B,C,D,0,F,H,I,J],[A,B,C,D,I,F,H,0,J]).
neighbor([A,B,C,D,E,0,H,I,J],[A,B,C,D,E,J,H,I,0]).
neighbor([0,B,C,D,E,F,H,I,J],[D,B,C,0,E,F,H,I,J]).
neighbor([A,0,C,D,E,F,H,I,J],[A,E,C,D,0,F,H,I,J]).
neighbor([A,B,0,D,E,F,H,I,J],[A,B,F,D,E,0,H,I,J]).

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
    X \= 0,
    I1 is Index1 div 3,
    I2 is Index2 div 3,
    J1 is Index1 mod 3,
    J2 is Index2 mod 3,
    HeuristicValue is abs(I1 - I2) + abs(J1 - J2).

h(State, HeuristicValue) :-
    findall(H, part_h(State, H), Hs),
    sum_list(Hs, HeuristicValue).
