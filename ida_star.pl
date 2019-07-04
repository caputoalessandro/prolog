:- use_module(library(ordsets)).
:- use_module(library(apply)).
:- ["azioni.pl", "dominio3.pl", "euristica_1.pl"].
:- set_prolog_stack(global, limit(100 000 000 000)).


:- (dynamic prossima_soglia/1).

ida_star(Soluzione) :-
    iniziale(S),
    euristica(S, SogliaIniziale),
    assert_prossima_soglia(SogliaIniziale),
    ida_star_aux(Soluzione).

ida_star_aux(Soluzione) :-
    prossima_soglia(Soglia),
    retract(prossima_soglia(_)),
    cost_limit_search(Soluzione, Soglia).

ida_star_aux(Soluzione) :-
    ida_star_aux(Soluzione).

cost_limit_search(Soluzione, CostoMaxCammino) :-
    iniziale(S),
    dfs_aux(S, Soluzione, [S], 0, CostoMaxCammino).

dfs_aux(S, _, _, CostoCammino, CostoMaxCammino) :-
    CostoCammino>CostoMaxCammino,
    !,
    euristica(S, Euristica),
    Soglia is CostoCammino+Euristica,
    assert_prossima_soglia(Soglia),
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

assert_prossima_soglia(NuovaSoglia) :-
    prossima_soglia(SogliaPrecedente),
    NuovaSoglia>=SogliaPrecedente,
    !.

assert_prossima_soglia(NuovaSoglia) :-
    retractall(prossima_soglia(_)),
    assert(prossima_soglia(NuovaSoglia)).

% ida_star_aux(S, [Azione|AzioniTail], Visitati, CostoAttuale) :-
