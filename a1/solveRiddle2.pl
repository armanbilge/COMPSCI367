fatherOf(Father, Person) :-
    parentOf(Father, Person),
    male(Father).

sonOf(Son, Person) :-
    parentOf(Person, Son),
    male(Son).

solveRiddle2(ManLooking, ManInPortrait) :-
    male(ManLooking),
    male(ManInPortrait),
    sonOf(Son, ManInPortrait),
    sonOf(MySon, ManLooking),
    fatherOf(Son, MySon).
