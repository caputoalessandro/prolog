
:- use_module(library(ordsets)).
:- ["blocchiord12.pl"].

block(a).
block(b).
block(c).

iniziale(S):- 
    list_to_ord_set([ontable(a), ontable(b), on(c,b), clear(a),clear(c),handempty], S).
    % crea  un insieme togliendo i doppioni 
    
goal(G):- list_to_ord_set([on(c,a),ontable(a),ontable(b),clear(b), handempty],G).

finale(S):- goal(G), ord_subset(G,S).

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

   


