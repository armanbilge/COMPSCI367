:- multifile op/4.
:- dynamic op/4.
:- multifile cost/3.
:- dynamic cost/3.

%% cost(State, Neighbor, ArcCost)
% all arcs (i.e., operator costs) are one unit
cost(_, _, 1).

op(reverse,
   %% reverse V
   [V],
   [hoodAt(V, H),
    trunkAt(V, T)],
   [hoodAt(V, T),
    trunkAt(V, H),
    not(hoodAt(V, H),
    not(trunkAt(V, T)))]).

op(move,
   %% move V forward one grid square
   [V],
   [hoodAt(V, H),
    trunkAt(V, T),
    locationRowColumn(H, RH, CH),
    locationRowColumn(T, RT, CT),
    direction(V, RD, CD),
    isExpression(RHM, RH + RD),
    isExpression(CHM, CH + CD),
    isExpression(RTM, RT + RD),
    isExpression(CTM, CT + CD),
    locationRowColumn(HM, RHM, CHM),
    locationRowColumn(TM, RTM, CTM),
    inGrid(HM),
    not(occupied(HM))],
   [hoodAt(V, HM),
    trunkAt(V, TM),
    not(hoodAt(V, H)),
    not(trunkAt(V, T))]).
