\newpage

## IDA\*

L'implementazione di IDA\* è simile a quella dell'Iterative Deepening. Ci sono
due predicati principali: `ida_star` e `cost_limit_search` (e i loro
corrispondenti predicati ausiliari). `cost_limit_search` ha il compito di
eseguire la ricerca in profondità, mentre `ida_star` stabilisce la soglia
massima di ogni chiamata di `cost_limit_search`.

Rispetto all'Iterative Deepening, c'è una differenza importante
nell'implementazione della ricerca limitata. Se `cost_limit_search` non trova
una soluzione una volta raggiunta la profondità massima, deve salvare le
informazioni necessarie a stabilire la profondità di ricerca successiva.
Abbiamo implementato questa feature usando il cut e una nuova clausola su
`dfs_aux`.

```prolog
cost_limit_search(Soluzione, CostoMaxCammino) :-
    iniziale(S),
    dfs_aux(S, Soluzione, [S], 0, CostoMaxCammino).

dfs_aux(S, _, _, CostoCammino, CostoMaxCammino) :-
    CostoCammino>CostoMaxCammino,
    !,
    euristica(S, Euristica),
    ProssimaSoglia is CostoCammino + Euristica,
    assert(prossima_soglia(ProssimaSoglia)),
    false.

dfs_aux(S, [], _, _, _) :-
    finale(S).
```

In `dfs_aux`, invece di ricevere una soglia in input, si considerano il costo
del cammino attuale e il costo massimo del cammino, che t

Quando `dfs_aux` viene valutato con un `CostoCammino` minore del
`CostoMaxCammino` scatta una seconda clausola, che a
