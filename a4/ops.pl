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
   [atHood(V, H),
    atTrunk(V, T)],
   [atHood(V, T),
    atTrunk(V, H),
    not(atHood(V, H),
    not(atTrunk(V, T)))]).

op(move,
   %% move V forward one grid square
   [V],
   [atHood(V, H),
    atTrunk(V, T),
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
   [atHood(V, HM),
    atTrunk(V, TM),
    not(atHood(V, H)),
    not(atTrunk(V, T))]).
