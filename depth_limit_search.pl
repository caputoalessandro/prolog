
:- use_module(library(ordsets)).
:- ["azioni.pl", "dominio.pl"].


% dfs_aux(S,ListaAzioni,Visitati,Soglia)
depth_limit_search(Soluzione,Soglia):-
    iniziale(S),
    dfs_aux(S,Soluzione,[S],Soglia).

dfs_aux(S,[],_,_):-finale(S).

dfs_aux(S,[Azione|AzioniTail],Visitati,Soglia):-
    Soglia>0,
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    \+member(SNuovo,Visitati),
    NuovaSoglia is Soglia-1,
    dfs_aux(SNuovo,AzioniTail,[SNuovo|Visitati],NuovaSoglia).
