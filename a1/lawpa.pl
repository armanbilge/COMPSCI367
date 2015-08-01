lawpa(Lawpa, Person) :-
    spouseOf(Spouse, Person),
    parentOf(Lawpa, Spouse),
    male(Lawpa).
