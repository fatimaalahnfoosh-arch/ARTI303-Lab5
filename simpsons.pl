% =========================================================
% ARTI 303 - Programming for AI
% Lab 5 - Working with Rules : Task 1 (Simpsons family tree)
% =========================================================

% ---------------- Facts: gender ----------------
male(abraham).
male(clancy).
male(herb).
male(homer).
male(bart).

female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).

% ---------------- Facts: parent(Parent, Child) ----------------
parent(abraham, herb).
parent(abraham, homer).
parent(mona, homer).

parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).

parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).

parent(selma, ling).

% ---------------- Rules ----------------

% X is the father of Y if X is a parent of Y and X is male.
father(X, Y) :- parent(X, Y), male(X).

% X is the mother of Y if X is a parent of Y and X is female.
mother(X, Y) :- parent(X, Y), female(X).

% X is the son of Y if Y is a parent of X and X is male.
son(X, Y) :- parent(Y, X), male(X).

% X is the daughter of Y if Y is a parent of X and X is female.
daughter(X, Y) :- parent(Y, X), female(X).

% Helper: X and Y share a parent and are different people.
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% X is the brother of Y if they are siblings and X is male.
brother(X, Y) :- sibling(X, Y), male(X).

% X is the sister of Y if they are siblings and X is female.
sister(X, Y) :- sibling(X, Y), female(X).

% X is the grandfather of Z if X is a parent of Y, Y is a parent of Z, and X is male.
grandfather(X, Z) :- parent(X, Y), parent(Y, Z), male(X).

% X is the aunt of Y if X is a sister of one of Y's parents.
aunt(X, Y) :- parent(P, Y), sister(X, P).

% X is the uncle of Y if X is a brother of one of Y's parents.
uncle(X, Y) :- parent(P, Y), brother(X, P).

% X and Y are cousins if a parent of X and a parent of Y are siblings.
cousin(X, Y) :- parent(P, X), parent(Q, Y), sibling(P, Q).

% Recursive rule:
% Base case     - a parent is an ancestor.
ancestor(X, Z) :- parent(X, Z).
% Recursive case - X is an ancestor of Z if X is a parent of some Y
%                  and Y is an ancestor of Z.
ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).

% =========================================================
% Test queries and answers (at least two per rule)
% Note: repeated answers (e.g. sister(X, bart)) are expected:
% Bart and Lisa share TWO parents (Homer and Marge), so Prolog
% finds the same sibling once through each parent.
% =========================================================

% ?- father(homer, bart).
%    true.

% ?- father(X, lisa).
%    X = homer.

% ?- mother(marge, maggie).
%    true.

% ?- mother(X, homer).
%    X = mona.

% ?- son(bart, marge).
%    true.

% ?- son(X, abraham).
%    X = herb ;
%    X = homer.

% ?- daughter(lisa, homer).
%    true.

% ?- daughter(X, jackie).
%    X = marge ;
%    X = patty ;
%    X = selma.

% ?- brother(bart, lisa).
%    true.

% ?- brother(X, homer).
%    X = herb.

% ?- sister(patty, selma).
%    true.

% ?- sister(X, bart).
%    X = lisa ;
%    X = maggie ;
%    X = lisa ;
%    X = maggie.

% ?- grandfather(clancy, bart).
%    true.

% ?- grandfather(X, maggie).
%    X = abraham ;
%    X = clancy.

% ?- aunt(selma, lisa).
%    true.

% ?- aunt(X, bart).
%    X = patty ;
%    X = selma ;
%    X = patty ;
%    X = selma.

% ?- uncle(herb, bart).
%    true.

% ?- uncle(X, maggie).
%    X = herb.

% ?- cousin(ling, bart).
%    true.

% ?- cousin(X, ling).
%    X = bart ;
%    X = bart ;
%    X = lisa ;
%    X = lisa ;
%    X = maggie ;
%    X = maggie.

% ?- ancestor(abraham, maggie).
%    true.

% ?- ancestor(X, ling).
%    X = selma ;
%    X = clancy ;
%    X = jackie.

