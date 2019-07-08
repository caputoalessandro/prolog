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
Abbiamo implementato questa feature usando il cut, un nuovo predicato
`assert_prossima_soglia` e una nuova clausola su `dfs_aux`.

```prolog
cost_limit_search(Soluzione, CostoMaxCammino) :-
    iniziale(S),
    dfs_aux(S, Soluzione, [S], 0, CostoMaxCammino).

dfs_aux(S, _, _, CostoCammino, CostoMaxCammino) :-
    CostoCammino>CostoMaxCammino,
    !,
    euristica(S, Euristica),
    Soglia is CostoCammino+Euristica,
    assert_prossima_soglia(Soglia),
    false.

dfs_aux(S, [], _, _, _) :-
    finale(S).
```

In `dfs_aux`, invece di ricevere una soglia in input, si considerano il costo
del cammino attuale e il costo massimo del cammino. Quando `dfs_aux` viene
valutato con un `CostoCammino > CostoMaxCammino`, questo calcola la stima del
costo per arrivare allo stato finale a partire dallo stato attuale, sommando
`CostoCammino` al risultato della funzione euristica, per poi asserire il
valore ottenuto nel predicato dinamico `prossima_soglia(S)`. Il predicato poi
fallisce per permettere di continuare la ricerca.

Se invece il costo è ancora sotto il massimo, l'algoritmo procede normalmente
con la ricerca limitata in profondità.

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

L'asserzione di `prossima_soglia` avviene tramite il predicato
`assert_prossima_soglia(NuovaSoglia)`. Questo controlla se il valore di
`NuovaSoglia` sia maggiore o uguale a un eventuale valore della soglia asserito
in precedenza. Se sì, il predicato esegue un cut e non effettua altre
operazioni, dato che ci interessa salvare solo il valore minimo tra quelli
delle soglie trovate.

Se invece non c'è una soglia salvata in precedenza, o se la `NuovaSoglia` è
minore di questa, `assert_prossima_soglia` procede a effettuare la `retract`
della soglia precedente e ad asserire quella nuova.

```prolog
assert_prossima_soglia(NuovaSoglia) :-
    prossima_soglia(SogliaPrecedente),
    NuovaSoglia>=SogliaPrecedente,
    !.

assert_prossima_soglia(NuovaSoglia) :-
    retractall(prossima_soglia(_)),
    assert(prossima_soglia(NuovaSoglia)).
```

Se alla fine della ricerca in profondità non è stata trovata una soluzione,
l'algoritmo fa partire una nuova ricerca, usando come nuova soglia massima la
soglia asserita in `prossima_soglia`. Questa logica è gestita
all'interno di `ida_star_aux`:

```prolog
ida_star_aux(Soluzione) :-
    prossima_soglia(Soglia),
    retract(prossima_soglia(_)),
    cost_limit_search(Soluzione, Soglia).

ida_star_aux(Soluzione) :- ida_star_aux(Soluzione).
```

In `ida_star_aux`, si trova la soglia tramite `prossima_soglia(Soglia)`, si
ritrae il predicato `prossima_soglia` e si procede a
effettuare la ricerca con limite di costo `Soglia`.
Se `cost_limit_search` non trova una soluzione, `ida_star_aux` si richiama
ricorsivamente, in modo che venga eseguita una nuova ricerca limitata nel
costo con il nuovo valore di soglia trovato.

L'algoritmo parte con il predicato `ida_star(Soluzione)`, che asserisce la
soglia al valore dell'euristica sullo stato iniziale e valuta il predicato
`ida_star_aux(Soluzione)`.

```prolog
ida_star(Soluzione) :-
    iniziale(S),
    euristica(S, SogliaIniziale),
    assert_prossima_soglia(SogliaIniziale),
    ida_star_aux(Soluzione).
```
