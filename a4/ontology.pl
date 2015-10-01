%%%%%%%%%%%%%%%
%
%  This is the skeletal ontology file, you need to add
%  the declarations of your predicates to this file
%
%%%%%%%%%%%%%%%


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
:- dynamic locationRowColumn/3.
derived(locationRowColumn/3).
%%%% L represents row R and column C
locationRowColumn(L, R, C) :- width(W), isExpression(L, R * W + C).
:- dynamic inGrid/1.
derived(inGrid/1).
inGrid(L) :- width(W), height(H), locationRowColumn(L, R, C), expression(R < H), expression(C < W).
:- dynamic occupies/2.
derived(occupies/2).
% occupies(V, L) :- hoodAt(V, L).
% occupies(V, L) :- trunkAt(V, L).
% occupies(V, L) :- locationRowColumn(L, R, C),
%                   isExpression(Q, R + 1),
%                   isExpression(S, R - 1),
%                   locationRowColumn(M, Q, C),
%                   locationRowColumn(N, S, C),
%                   occupies(V, M),
%                   occupies(V, N).
% occupies(V, L) :- locationRowColumn(L, R, C),
%                   isExpression(Q, R + 1),
%                   isExpression(S, R - 1),
%                   locationRowColumn(M, Q, C),
%                   locationRowColumn(N, S, C),
%                   occupies(V, M),
%                   occupies(V, N).
occupies(V, L) :- locationRowColumn(L, _, C),
                  locationRowColumn(M, _, C),
                  locationRowColumn(N, _, C),
                  hoodAt(V, M),
                  trunkAt(V, N).
occupies(V, L) :- locationRowColumn(L, R, _),
                  locationRowColumn(M, R, _),
                  locationRowColumn(N, R, _),
                  hoodAt(V, M),
                  trunkAt(V, N).
:- dynamic occupied/1.
derived(occupied/1).
occupied(L) :- occupies(_, L).
:- dynamic direction/3.
derived(direction/3).
direction(V, R, C) :- hoodAt(V, H),
                      trunkAt(V, T),
                      locationRowColumn(H, RH, CH),
                      locationRowColumn(T, RT, CT),
                      expression(RH > RT),
                      expression(CH = CT),
                      expression(R = 1),
                      expression(C = 0).
direction(V, R, C) :- hoodAt(V, H),
                      trunkAt(V, T),
                      locationRowColumn(H, RH, CH),
                      locationRowColumn(T, RT, CT),
                      expression(RH < RT),
                      expression(CH = CT),
                      expression(R = -1),
                      expression(C = 0).
direction(V, R, C) :- hoodAt(V, H),
                      trunkAt(V, T),
                      locationRowColumn(H, RH, CH),
                      locationRowColumn(T, RT, CT),
                      expression(RH = RT),
                      expression(CH > CT),
                      expression(R = 0),
                      expression(C = 1).
direction(V, R, C) :- hoodAt(V, H),
                      trunkAt(V, T),
                      locationRowColumn(H, RH, CH),
                      locationRowColumn(T, RT, CT),
                      expression(RH = RT),
                      expression(CH < CT),
                      expression(R = 0),
                      expression(C = -1).

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
