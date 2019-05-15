:- use_module(library(ordsets)).
:- ["azioni.pl", "dominio.pl"].

heuristic(_, 1).

ida_star(Soluzione) :-
    iniziale(S),
    heuristic(S,SogliaMassima),
    ida_star_aux(S,SogliaMassima,Soluzione).

ida_star_aux(S, SogliaMassima, Soluzione) :- 
    findall 
    dfs_aux(S, Soluzione, [S], 0, SogliaMassima).

ida_star_aux(S) :- 

    dfs_aux(S, Soluzione, [S], 0, SogliaMassima).


dfs_aux(S, [], _, _, _) :-
    finale(S).

dfs_aux(S, [Azione|AzioniTail], Visitati, SogliaAttuale, SogliaMassima) :-
    SogliaAttuale =< SogliaMassima,
    !,
    applicabile(Azione, S),
    trasforma(Azione, S, SNuovo),
    \+ member(SNuovo, Visitati),
    NuovaSoglia is SogliaAttuale + 1,
    dfs_aux(SNuovo, AzioniTail, [SNuovo|Visitati], NuovaSoglia, SogliaMassima).


dfs_aux(S, _, _, SogliaAttuale, _) :-
    heuristic(S, EuristicaDaStatoCorrente),
    EuristicaNuovaSoglia is EuristicaDaStatoCorrente + SogliaAttuale,
    assert(euristica_nuova_soglia(EuristicaNuovaSoglia)),
    false.

% ida_star_aux(S, [Azione|AzioniTail], Visitati, CostoAttuale) :-
