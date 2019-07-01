:- use_module(library(ordsets)).
:- use_module(library(apply)).
:- ["azioni.pl", "dominio.pl"].

is_on(on(_,_)).

euristica(StatoAttuale, Valore) :-
    goal(StatoFinale),
    ord_subtract(StatoFinale, StatoAttuale, DifferenzaStati),
    include(is_on, DifferenzaStati, StatiOn),
    length(StatiOn, LunghezzaStatiOn),
    Valore is max(1, LunghezzaStatiOn).

ida_star(Soluzione) :-
    iniziale(S),
    euristica(S, SogliaMassima),
    ida_star_aux(Soluzione, SogliaMassima).

ida_star_aux(Soluzione, SogliaMassima) :-
    depth_limit_search(Soluzione, SogliaMassima).

ida_star_aux(Soluzione, SogliaMassimaAttuale) :-
    findall(X, euristica_da_max_profondita(X), ListaEuristiche),
    min_list(ListaEuristiche, MinimoEuristiche),
    retractall(euristica_da_max_profondita(_)),
    NuovaSogliaMassima is SogliaMassimaAttuale+MinimoEuristiche,
    ida_star_aux(Soluzione, NuovaSogliaMassima).

depth_limit_search(Soluzione, Soglia) :-
    iniziale(S),
    dfs_aux(S, Soluzione, [S], Soglia).

dfs_aux(S, [], _, _) :-
    finale(S).

dfs_aux(S, [Azione|AzioniTail], Visitati, Soglia) :-
    Soglia>0,
    !,
    applicabile(Azione, S),
    trasforma(Azione, S, SNuovo),
    \+ member(SNuovo, Visitati),
    NuovaSoglia is Soglia-1,
    dfs_aux(SNuovo, AzioniTail, [SNuovo|Visitati], NuovaSoglia).


dfs_aux(S, _, _, _) :-
    euristica(S, EuristicaDaMaxProfondita),
    assert(euristica_da_max_profondita(EuristicaDaMaxProfondita)),
    false.

% ida_star_aux(S, [Azione|AzioniTail], Visitati, CostoAttuale) :-
