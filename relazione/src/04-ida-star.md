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
del cammino attuale e il costo massimo del cammino. Quando `dfs_aux` viene
valutato con un `CostoCammino > CostoMaxCammino`, questo calcola la stima del
costo per arrivare allo stato finale usando `CostoCammino` e la funzione
euristica, per poi asserire il valore ottenuto in un fatto
`prossima_soglia(S)`. Il predicato poi fallisce per permettere di continuare la
ricerca.

Se invece il costo è ancora sotto il massimo, l'algoritmo procede normalmente
con la ricerca limitata (nel costo) in profondità.

```prolog
dfs_aux(
  S, [Azione|AzioniTail], Visitati, CostoCammino, CostoMaxCammino
) :-
  applicabile(Azione, S),
  trasforma(Azione, S, SNuovo),
  \+ member(SNuovo, Visitati),
  costo(Azione, CostoAzione),
  NuovoCostoCammino is CostoCammino+CostoAzione,
  dfs_aux(
    SNuovo, AzioniTail, [SNuovo|Visitati], 
    NuovoCostoCammino, CostoMaxCammino
  ).
```

Se alla fine della ricerca in profondità non è stata trovata una soluzione,
l'algoritmo fa partire una nuova ricerca, usando come nuova soglia massima la
soglia minima tra quelle asserite in `prossima_soglia`. Questa logica è gestita
all'interno di `ida_star_aux`:

```prolog
ida_star_aux(Soluzione, SogliaMassima) :-
    cost_limit_search(Soluzione, SogliaMassima).

ida_star_aux(Soluzione, _) :-
    findall(X, prossima_soglia(X), ListaSoglie),
    min_list(ListaSoglie, SogliaSuccessiva),
    retractall(prossima_soglia(_)),
    ida_star_aux(Soluzione, SogliaSuccessiva).
```

Con `findall`, si trovano tutti i valori `X` che unificano con
`prossima_soglia(X)`, che vengono inseriti nella variabile di output
`ListaSoglie`. Si ricava poi il minimo dei valori tramite `min_list`, si esegue
la `retract` dei fatti `prossima_soglia` (che altrimenti andrebbero a
interferire nell'esecuzione successiva del predicato) e si procede a chiamare
ricorsivamente `ida_star_aux` con la nuova soglia trovata. Questi passi vengono
eseguiti finché non viene trovata una soluzione.
