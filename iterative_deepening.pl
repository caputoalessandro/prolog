:- use_module(library(ordsets)).
:- ["depth_limit_search.pl", "dominio.pl"].


iterative_deepening(Soluzione, SogliaMax) :-
    iterative_deepening_aux(Soluzione, 0, 1, SogliaMax).

iterative_deepening_aux(Soluzione, SogliaCorrente, _, _) :-
    depth_limit_search(Soluzione, SogliaCorrente).

iterative_deepening_aux(Soluzione, SogliaPrecedente, SogliaSuccessiva, SogliaMassima) :-
    SogliaSuccessiva is SogliaPrecedente+1,
    SogliaSuccessiva<SogliaMassima,
    iterative_deepening_aux(Soluzione, SogliaSuccessiva, _, SogliaMassima).