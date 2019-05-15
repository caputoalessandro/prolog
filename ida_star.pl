:- use_module(library(ordsets)).
:- ["azioni.pl", "dominio.pl"].

heuristic(_, 1).

ida_star(Soluzione, Soglia) :-
    iniziale(S),
    ida_star_aux(S, Soluzione, [S], Soglia, 0).

ida_star_aux(S, [], _, _, _) :-
    finale(S).

ida_star_aux(S, [Azione|AzioniTail], Visitati, Soglia, CostoAttuale) :-
    Soglia>0,
    applicabile(Azione, S),
    trasforma(Azione, S, SNuovo),
    \+ member(SNuovo, Visitati),
    heuristic(SNuovo, Costo_stimato),
    costo(Azione, CostoAzione),
    CostoSuccessivo is CostoAttuale+CostoAzione,
    NuovaSoglia is Costo_stimato+CostoSuccessivo,
    ida_star_aux(SNuovo,
                 AzioniTail,
                 [SNuovo|Visitati],
                 NuovaSoglia,
                 CostoSuccessivo).
