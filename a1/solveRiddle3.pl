fatherOf(Father, Person) :-
    parentOf(Father, Person),
    male(Father).

grandfatherOf(Grandfather, Person) :-
    parentOf(Parent, Person),
    fatherOf(Grandfather, Parent).

solveRiddle3(Person, PersonsGrandfather) :-
    grandfatherOf(PersonsGrandfather, Person),
    fatherOf(Father, Person),
    not(olderThan(PersonsGrandfather, Father)).
