:- use_module(library(ordsets)).
:- ["azioni.pl", "dominio.pl"].

heuristic(_,1).

% dfs_aux(S,ListaAzioni,Visitati,Soglia)
ida_star(Soluzione,Soglia):-
    iniziale(S),
    ida_star_aux(S,Soluzione,[S],Soglia,0).

ida_star_aux(S,[],_,_,_) :- finale(S).

ida_star_aux(S,[Azione|AzioniTail],Visitati,Soglia,Costo_attuale):-
    Soglia>0,
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    \+member(SNuovo,Visitati),
    heuristic(SNuovo,Costo_stimato),
    costo(Azione,Costo_azione),
    Costo_successivo is Costo_attuale + Costo_azione,
    NuovaSoglia is Costo_stimato + Costo_successivo,
    ida_star_aux(SNuovo,AzioniTail,[SNuovo|Visitati],NuovaSoglia,Costo_successivo).
