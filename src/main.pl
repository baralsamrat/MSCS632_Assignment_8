/* ──────────────────────────────────────────────────────────
   Simple Family-Tree Knowledge Base
   File: main.pl
   Author: Samrat Baral   |   Course: ---
   Purpose:   Demonstrate basic and derived relationships
              (parent, grandparent, sibling, cousin,
               ancestor / descendant) using Prolog.
   ────────────────────────────────────────────────────────── */

/* ─── Basic Facts ───────────────────────────────────────── */

% parent(Parent, Child).
parent(john,  mary).   parent(john,  james).
parent(jane,  mary).   parent(jane,  james).

parent(mary,  alice).  parent(mary,  bob).
parent(peter, alice).  parent(peter, bob).

parent(james, charlie).
parent(anna,  charlie).

% Gender facts (handy for extra queries)
male(john).   male(james).  male(peter).
male(bob).    male(charlie).

female(jane). female(mary).  female(anna).
female(alice).

/* ─── Derived Relationships ─────────────────────────────── */

% child/2 is just the inverse of parent/2.
child(C, P) :- parent(P, C).

% grandparent(GP, GC)  - one generation up twice
grandparent(GP, GC) :-
    parent(GP, P),
    parent(P,  GC).

% sibling(S1, S2)  - share at least one parent and are different people
sibling(S1, S2) :-
    parent(P, S1),
    parent(P, S2),
    S1 \= S2.

% cousin(C1, C2)  - their parents are siblings
cousin(C1, C2) :-
    parent(P1, C1),
    parent(P2, C2),
    sibling(P1, P2).

/* Recursive ancestor/descendant logic  */

% ancestor(Anc, Desc)  - direct parent …
ancestor(Anc, Desc) :- parent(Anc, Desc).
% … or parent of an ancestor (recursion)
ancestor(Anc, Desc) :-
    parent(Anc, X),
    ancestor(X, Desc).

% descendant(Desc, Anc) is the inverse of ancestor/descendant
descendant(Desc, Anc) :- ancestor(Anc, Desc).

/* ───────────────────────────────────────────────────────── */
