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
    cost_limit_search(Soluzione, SogliaMassima).

ida_star_aux(Soluzione, _) :-
    findall(X, prossima_soglia(X), ListaSoglie),
    min_list(ListaSoglie, SogliaSuccessiva),
    retractall(prossima_soglia(_)),
    ida_star_aux(Soluzione, SogliaSuccessiva).

cost_limit_search(Soluzione, CostoMaxCammino) :-
    iniziale(S),
    dfs_aux(S, Soluzione, [S], 0, CostoMaxCammino).

dfs_aux(S, _, _, CostoCammino, CostoMaxCammino) :-
    CostoCammino>CostoMaxCammino,
    !,
    euristica(S, Euristica),
    ProssimaSoglia is CostoCammino + Euristica,
    assert(prossima_soglia(ProssimaSoglia)),
    false.

dfs_aux(S, [], _, _, _) :-
    finale(S).

dfs_aux(S, [Azione|AzioniTail], Visitati, CostoCammino, CostoMaxCammino) :-
    applicabile(Azione, S),
    trasforma(Azione, S, SNuovo),
    \+ member(SNuovo, Visitati),
    costo(Azione, CostoAzione),
    NuovoCostoCammino is CostoCammino+CostoAzione,
    dfs_aux(SNuovo, AzioniTail, [SNuovo|Visitati], NuovoCostoCammino, CostoMaxCammino).


% ida_star_aux(S, [Azione|AzioniTail], Visitati, CostoAttuale) :-
