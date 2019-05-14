:- use_module(library(ordsets)).
:- ["azioni.pl", "dominio.pl"].

block(a).
block(b).
block(c).

costo(_,1).

iniziale(S):-
    list_to_ord_set([ontable(a), ontable(b), on(c,b), clear(a),clear(c),handempty], S).
    % crea  un insieme togliendo i doppioni

goal(G):- list_to_ord_set([on(c,a),ontable(a),ontable(b),clear(b), handempty],G).

finale(S):- goal(G), ord_subset(G,S).

heuristic(_,1).

% dfs_aux(S,ListaAzioni,Visitati,Soglia)
depth_limit_search(Soluzione,Soglia):-
    iniziale(S),
    dfs_aux(S,Soluzione,[S],Soglia,0).

dfs_aux(S,[],_,_):-finale(S).

dfs_aux(S,[Azione|AzioniTail],Visitati,Soglia,Costo_attuale):-
    Soglia>0,
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    \+member(SNuovo,Visitati),
    heuristic(SNuovo,Costo_stimato),
    costo(Azione,Costo_azione),
    Costo_successivo is Costo_attuale + Costo_azione,
    NuovaSoglia is Costo_stimato + Costo_successivo,
    dfs_aux(SNuovo,AzioniTail,[SNuovo|Visitati],NuovaSoglia,Costo_successivo).
