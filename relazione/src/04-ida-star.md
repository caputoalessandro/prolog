# IDA*

L'implementazione di IDA\* è simile a quella dell'Iterative Deepening. Ci sono
due predicati principali: `ida_star` e `depth_limit_search` (e i loro
corrispondenti predicati ausiliari). `depth_limit_search` ha il compito di
eseguire la ricerca in profondità, mentre `ida_star` stabilisce la soglia
massima di profondità per ogni iterazione per poi richiamare
`depth_limit_search`.

Rispetto all'Iterative Deepening, c'è una differenza importante
nell'implementazione di `depth_limit_search`. Se `depth_limit_search` non trova
una soluzione una volta raggiunta la profondità massima, deve salvare le
informazioni necessarie a stabilire la profondità di ricerca successiva.
Abbiamo implementato questa feature usando il cut e una nuova clausola su
`dfs_aux`.

```prolog
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
```

Quando la soglia scende a 0, si attiva la seconda clausola 
