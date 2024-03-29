fatherOf(Father, Person) :-
    parentOf(Father, Person),
    male(Father).

sonOf(Son, Person) :-
    parentOf(Person, Son),
    male(Son).

solveRiddle1(ManLooking, ManInPortrait) :-
    male(ManLooking),
    male(ManInPortrait),
    fatherOf(Father, ManInPortrait),
    fatherOf(MyFather, ManLooking),
    sonOf(Father, MyFather).
