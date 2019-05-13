:- use_module(library(ordsets)).
:- ["dfslimitata.pl"].


iterative_deepening(Soluzione, Soglia_corrente,_,_) :-
    depth_limit_search(Soluzione, Soglia_corrente).

iterative_deepening(Soluzione, SogliaPrecedente, SogliaSuccessiva, Soglia_massima) :-
    SogliaSuccessiva is SogliaPrecedente + 1,
    SogliaSuccessiva < Soglia_massima,
    iterative_deepening(Soluzione, SogliaSuccessiva,_,Soglia_massima).