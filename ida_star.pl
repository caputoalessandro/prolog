:- use_module(library(ordsets)).
:- use_module(library(apply)).
:- ["azioni.pl", "dominio.pl"].

identity(X, X).
is_on(X) :-
    identity(X, on(_, _)).

euristica(StatoAttuale, Valore) :-
    goal(StatoFinale),
    ord_subtract(StatoFinale, StatoAttuale, DifferenzaStati),
    include(is_on, DifferenzaStati, StatiOn),
    length(StatiOn, LunghezzaStatiOn),
    Valore is max(1, LunghezzaStatiOn).

ida_star(Soluzione) :-
    iniziale(S),
    euristica(S, SogliaMassima),
    ida_star_aux(S, SogliaMassima, Soluzione).

ida_star_aux(S, SogliaMassima, Soluzione) :-
    dfs_aux(S, Soluzione, [S], SogliaMassima).

ida_star_aux(S, SogliaMassimaAttuale, Soluzione) :-
    findall(X, euristica_da_max_profondita(X), ListaEuristiche),
    min_list(ListaEuristiche, MinimoEuristiche),
    retractall(euristica_da_max_profondita(_)),
    NuovaSogliaMassima is SogliaMassimaAttuale+MinimoEuristiche,
    ida_star_aux(S, NuovaSogliaMassima, Soluzione).

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
