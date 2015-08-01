lawneph(Lawneph, Person) :-
    spouseOf(Spouse, Person),
    parentOf(Parent, Spouse),
    parentOf(Parent, Sibling),
    parentOf(Sibling, Child),
    male(Child).
