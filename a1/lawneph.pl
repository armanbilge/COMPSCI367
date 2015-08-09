siblingOf(Sibling, Person) :-
    parentOf(Parent, Person),
    parentOf(Parent, Sibling),
    Sibling \= Person.

sonOf(Son, Person) :-
    parentOf(Person, Son),
    male(Son).

nephewOf(Nephew, Person) :-
    siblingOf(Sibling, Person),
    sonOf(Nephew, Sibling).

lawneph(Lawneph, Person) :-
    spouseOf(Spouse, Person),
    nephewOf(Lawneph, Spouse).
