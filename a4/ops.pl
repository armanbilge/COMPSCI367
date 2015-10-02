:- multifile op/4.
:- dynamic op/4.
:- multifile cost/3.
:- dynamic cost/3.

%% cost(State, Neighbor, ArcCost)
% all arcs (i.e., operator costs) are one unit
cost(_, _, 1).

op(reverse,
   %% reverse V
   [V, H, T],
   [hoodAt(V, H),
    trunkAt(V, T)],
   [hoodAt(V, T),
    trunkAt(V, H),
    not(hoodAt(V, H)),
    not(trunkAt(V, T))]).

op(move,
   %% move V forward one grid square
   [V, H, T, RH, CH, RT, CT, RD, CD, RHM, CHM, RTM, CTM, HM, TM],
   [hoodAt(V, H),
    trunkAt(V, T),
    rowColumn(H, RH, CH),
    rowColumn(T, RT, CT),
    direction(V, RD, CD),
    isExpression(RHM, RH + RD),
    isExpression(CHM, CH + CD),
    isExpression(RTM, RT + RD),
    isExpression(CTM, CT + CD),
    location(HM, RHM, CHM),
    location(TM, RTM, CTM),
    inGrid(RHM, CHM),
    not(occupied(HM))],
   [hoodAt(V, HM),
    trunkAt(V, TM),
    not(hoodAt(V, H)),
    not(trunkAt(V, T))]).
