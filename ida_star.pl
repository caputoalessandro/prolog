:- use_module(library(ordsets)).
:- ["azioni.pl", "dominio.pl"].

euristica(StatoAttuale, Valore) :-
    goal(StatoFinale),
    ord_subtract(StatoAttuale, StatoFinale, DifferenzaStati),
    length(DifferenzaStati, Valore).

ida_star(Soluzione) :-
    iniziale(S),
    euristica(S, SogliaMassima),
    ida_star_aux(S, SogliaMassima, Soluzione).

ida_star_aux(S, SogliaMassima, Soluzione) :-
    dfs_aux(S, Soluzione, [S], 0, SogliaMassima).

ida_star_aux(S, _, Soluzione) :-
    findall(X, euristica_nuova_soglia(X), ListaEuristiche),
    min_list(ListaEuristiche, Minimmo),
    retractall(euristica_nuova_soglia(_)),
    ida_star_aux(S, Minimmo, Soluzione).

dfs_aux(S, [], _, _, _) :-
    finale(S).

dfs_aux(S, [Azione|AzioniTail], Visitati, SogliaAttuale, SogliaMassima) :-
    SogliaAttuale=<SogliaMassima,
    !,
    applicabile(Azione, S),
    trasforma(Azione, S, SNuovo),
    \+ member(SNuovo, Visitati),
    NuovaSoglia is SogliaAttuale+1,
    dfs_aux(SNuovo, AzioniTail, [SNuovo|Visitati], NuovaSoglia, SogliaMassima).


dfs_aux(S, _, _, SogliaAttuale, _) :-
    euristica(S, EuristicaDaStatoCorrente),
    EuristicaNuovaSoglia is EuristicaDaStatoCorrente+SogliaAttuale,
    assert(euristica_nuova_soglia(EuristicaNuovaSoglia)),
    false.

% ida_star_aux(S, [Azione|AzioniTail], Visitati, CostoAttuale) :-
