fatherOf(Father, Person) :-
    parentOf(Father, Person),
    male(Father).

lawpa(Lawpa, Person) :-
    spouseOf(Spouse, Person),
    fatherOf(Lawpa, Spouse).
