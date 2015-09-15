:- add_rule(
initiate_smaller
    if
        criterion(A) and
        object(X) and
        not(sorted(X)) and
        not(object(Y) and smallest(Y, A))
    then
        add(try_find_smallest(A)) and
        add(smallest(X, A))).

:- add_rule(
update_smaller
    if
        try_find_smallest(A) and
        smallest(X, A) and
        object(X) and
        value(X, A, V1) and
        object(Y) and
        value(Y, A, V2) and
        less_than(V2, V1) and
        not(sorted(Y))
    then
        remove(smallest(X, A)) and
        add(smallest(Y, A))).

:- add_rule(
end_smaller
    if
        try_find_smallest(A)
    then
        remove(try_find_smallest(A)) and
        add(try_sort(A))).

:- add_rule(
initiate_sort
    if
        try_sort(A) and
        object(X) and
        smallest(X, A) and
        not(object(Y) and sorted(Y))
    then
        remove(try_sort(A)) and
        remove(smallest(X, A)) and
        add(sorted(X)) and
        add(latest(X)) and
        remove(criterion(A)) and
        add(criterion(A))).

:- add_rule(
extend_sort
    if
        try_sort(A) and
        object(X) and
        smallest(X, A) and
        object(Y) and
        sorted(Y) and
        latest(Y)
    then
        remove(try_sort(A)) and
        remove(smallest(X, A)) and
        add(sorted(X)) and
        remove(latest(Y)) and
        add(latest(X)) and
        add(left_of(X, Y)) and
        remove(criterion(A)) and
        add(criterion(A))).

:- add_rule(
end_sort
    if
        criterion(A)
    then
        print('Finished sorting on ') and
        print(A) and
        print('.\n')).
