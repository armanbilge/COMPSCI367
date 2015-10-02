%% static predicates info
:- dynamic static/1.
static(width/1).
static(height/1).

%% fluent predicates info
:- dynamic fluent/1.
% fluents are not statics
fluent(Pred/Arity) :- not(static(Pred/Arity)).

%% derived predicates info
:- dynamic derived/1.
:- dynamic location/3.
derived(location/3).
%%%% L represents row R and column C
location(L, R, C) :- width(W), isExpression(L, R * W + C).
:- dynamic rowColumn/3.
derived(rowColumn/3).
%%%% L represents row R and column C
rowColumn(L, R, C) :- width(W), isExpression(R, L // W), isExpression(C, L mod W).
:- dynamic inGrid/2.
derived(inGrid/2).
%%%% Square (R, C) is in the grid
inGrid(R, C) :- width(W),
                height(H),
                expression(0 =< R),
                expression(R < H),
                expression(0 =< C),
                expression(C < W).
:- dynamic occupies/2.
derived(occupies/2).
occupies(V, L) :- hoodAt(V, M),
                  trunkAt(V, N),
                  rowColumn(L, R, C),
                  rowColumn(M, R1, C),
                  rowColumn(N, R2, C),
                  expression(R =< R1),
                  expression(R >= R2).
occupies(V, L) :- hoodAt(V, M),
                  trunkAt(V, N),
                  rowColumn(L, R, C),
                  rowColumn(M, R1, C),
                  rowColumn(N, R2, C),
                  expression(R =< R2),
                  expression(R >= R1).
occupies(V, L) :- hoodAt(V, M),
                  trunkAt(V, N),
                  rowColumn(L, R, C),
                  rowColumn(M, R, C1),
                  rowColumn(N, R, C2),
                  expression(C =< C1),
                  expression(C >= C2).
occupies(V, L) :- hoodAt(V, M),
                  trunkAt(V, N),
                  rowColumn(L, R, C),
                  rowColumn(M, R, C1),
                  rowColumn(N, R, C2),
                  expression(C =< C2),
                  expression(C >= C1).
:- dynamic occupied/1.
derived(occupied/1).
occupied(L) :- occupies(_, L).
:- dynamic direction/3.
derived(direction/3).
direction(V, 1, 0) :- hoodAt(V, H),
                      trunkAt(V, T),
                      rowColumn(H, RH, C),
                      rowColumn(T, RT, C),
                      expression(RH > RT).
direction(V, -1, 0) :- hoodAt(V, H),
                       trunkAt(V, T),
                       rowColumn(H, RH, C),
                       rowColumn(T, RT, C),
                       expression(RH < RT).
direction(V, 0, 1) :- hoodAt(V, H),
                      trunkAt(V, T),
                      rowColumn(H, R, CH),
                      rowColumn(T, R, CT),
                      expression(CH > CT).
direction(V, 0, -1) :- hoodAt(V, H),
                       trunkAt(V, T),
                       rowColumn(H, R, CH),
                       rowColumn(T, R, CT),
                       expression(CH < CT).

%% primitive predicates info
:- dynamic primitive/1.
% primitives are not derived
primitive(Pred/Arity) :- not(derived(Pred/Arity)).

%% metaLevel predicates info
:- dynamic metaLevel/1.
:- dynamic isExpression/2.
metaLevel(isExpression/2).
%%%% Z is equal to some expression
isExpression(Z, Ex) :- Z is Ex.
:-dynamic expression/1.
metaLevel(expression/1).
%%%% Expression is true
expression(Ex) :- Ex.

%% objectLevel predicates info
:- dynamic objectLevel/1.
% objectLevel is not metaLevel
objectLevel(Pred/Arity) :- not(metaLevel(Pred/Arity)).
