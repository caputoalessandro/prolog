:- use_module(library(apply)).
:- ["dominio.pl"].

euristica(Stato, Valore) :-
    goal(Goal)
    member(ontable(X), Stato),
    member(ontable(X), Goal),

