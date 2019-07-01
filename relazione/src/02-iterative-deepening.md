<!-- -->

# Iterative Deepening

Per l'implementazione dell'algoritmo di Iterative Deepening, abbiamo
riutilizzato il codice riguardante la ricerca in profondità visto a lezione, in particolare il predicato `depth_limit_search`.

```prolog
depth_limit_search(Soluzione, Soglia) :-
    iniziale(S),
    dfs_aux(S, Soluzione, [S], Soglia).

dfs_aux(S, [], _, _) :-
    finale(S).

dfs_aux(S, [Azione|AzioniTail], Visitati, Soglia) :-
    Soglia>0,
    applicabile(Azione, S),
    trasforma(Azione, S, SNuovo),
    \+ member(SNuovo, Visitati),
    NuovaSoglia is Soglia-1,
    dfs_aux(SNuovo, AzioniTail, [SNuovo|Visitati], NuovaSoglia).
```

`depth_limit_search` esegue una ricerca in profondità limitata a partire dallo
stato iniziale. Nell'implementazione dell'Iterative Deepening lo andiamo a
richiamare aumentando la soglia di un'unità per ogni iterazione. Permettiamo
all'utente di stabilire una soglia massima, ovvero oltre la quale l'algoritmo termina
se non ha ancora trovato una soluzione.

```prolog

iterative_deepening(Soluzione, SogliaMax) :-
    iterative_deepening_aux(Soluzione, 1, SogliaMax).

iterative_deepening_aux(Soluzione, SogliaCorrente, _) :-
    depth_limit_search(Soluzione, SogliaCorrente).

iterative_deepening_aux(Soluzione, SogliaCorrente, SogliaMassima) :-
    SogliaSuccessiva is SogliaCorrente+1,
    SogliaSuccessiva=<SogliaMassima,
    iterative_deepening_aux(Soluzione, SogliaSuccessiva, SogliaMassima).

```

`iterative_deepening` funge da interfaccia utente per il predicato. Accetta
come parametri la soluzione e la soglia massima. Il predicato ausiliario
`iterative_deepening_aux` accetta come ulteriore parametro `SogliaCorrente`,
che rappresenta la profondità in cui si sta permettendo l'esplorazione
all'algoritmo nell'iterazione corrente.

L'algoritmo inizia chiamando `iterative_deepening_aux` con soglia corrente 1.
`iterative_deepening_aux` esegue la ricerca in profondità con soglia
`SogliaCorrente`
