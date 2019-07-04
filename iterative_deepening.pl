:- ["depth_limit_search.pl", "dominio2.pl"].
:- set_prolog_stack(global, limit(100 000 000 000)).

iterative_deepening(Soluzione, SogliaMax) :-
    iterative_deepening_aux(Soluzione, 1, SogliaMax).

iterative_deepening_aux(Soluzione, SogliaCorrente, _) :-
    depth_limit_search(Soluzione, SogliaCorrente).

iterative_deepening_aux(Soluzione, SogliaCorrente, SogliaMassima) :-
    SogliaSuccessiva is SogliaCorrente+1,
    SogliaSuccessiva=<SogliaMassima,
    iterative_deepening_aux(Soluzione, SogliaSuccessiva, SogliaMassima).