:- add_rule(
pick_up
  if task(pick_up(X)) and
     block(X) and table(Y) and on(X, Y) and
     hand(Z) and not(holding(Z, _))
  then remove(task(pick_up(X))) and
       remove(on(X, Y)) and add(holding(Z, X))).

:- add_rule(
unstack
  if task(unstack(X, Y)) and
     block(X) and block(Y) and hand(Z) and
     on(X, Y) and not(on(_, X)) and not(holding(Z, _))
  then remove(task(unstack(X, Y))) and
       remove(on(X, Y)) and add(holding(Z, X))).

:- add_rule(
put_down
  if task(put_down(X)) and
     block(X) and table(Y) and hand(Z) and
     holding(Z, X)
  then remove(task(put_down(X))) and
       remove(holding(Z, X)) and add(on(X, Y))).

:- add_rule(
stack
  if task(stack(X, Y)) and
     block(X) and block(Y) and hand(Z) and
     holding(Z, X) and not(on(_, Y))
  then remove(task(stack(X, Y))) and
       remove(holding(Z, X)) and add(on(X, Y))).

:- add_rule(
unstack_and_put_down
    if
        task(unstack_and_put_down(X, Y))
    then
        remove(task(unstack_and_put_down(X, Y))) and
        add(task(unstack(X, Y))) and
        add(task(put_down(X)))).

:- add_rule(
unstack_and_stack
    if
        task(unstack_and_stack(X, Y, Z))
    then
        remove(task(unstack_and_stack(X, Y, Z))) and
        add(task(unstack(X, Y))) and
        add(task(stack(X, Z)))).

:- add_rule(
pick_up_and_stack
    if
        task(pick_up_and_stack(X, Y))
    then
        remove(task(pick_up_and_stack(X, Y))) and
        add(task(pick_up(X))) and
        add(task(stack(X, Y)))).

:- add_rule(
invert_tower1
    if
        task(invert_tower([X,Y|Z])) and
        not(inverted_tower(_))
    then
        remove(task(invert_tower([X,Y|Z]))) and
        add(task(unstack_and_put_down(X, Y))) and
        add(inverted_tower([X])) and
        add(task(invert_tower([Y|Z])))).

:- add_rule(
invert_tower2
    if
        task(invert_tower([X,Y|Z])) and
        inverted_tower([U|V])
    then
        remove(task(invert_tower([X,Y|Z]))) and
        add(task(unstack_and_stack(X, Y, U))) and
        remove(inverted_tower([U|V])) and
        add(inverted_tower([X,U|V])) and
        add(task(invert_tower([Y|Z])))).

:- add_rule(
invert_tower3
    if
        task(invert_tower([X])) and
        inverted_tower([U|V])
    then
        remove(task(invert_tower([X]))) and
        add(task(pick_up_and_stack(X, U))) and
        remove(inverted_tower([U|V])) and
        add(inverted_tower([X,U|V]))).

:- add_rule(
invert_done
    if
        not(task(invert_tower(_))) and
        inverted_tower(X)
    then
        print('I have inverted the tower to produce ') and
        print(X) and
        print('.\n') and
        end).
