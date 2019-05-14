:- use_module(library(ordsets)).
:- ["depth_limit_search.pl", "dominio.pl"].


iterative_deepening(Soluzione, SogliaCorrente,_,_) :-
    depth_limit_search(Soluzione, SogliaCorrente).

iterative_deepening(Soluzione, SogliaPrecedente, SogliaSuccessiva, SogliaMassima) :-
    SogliaSuccessiva is SogliaPrecedente + 1,
    SogliaSuccessiva < SogliaMassima,
    iterative_deepening(Soluzione, SogliaSuccessiva,_,SogliaMassima).