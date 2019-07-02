\newpage

# Ricerca informata

Nell'implementazione degli algoritmi di ricerca informata, abbiamo anche tenuto
in conto del fatto che i costi delle azioni potrebbero differire tra loro, e
non essere necessariamente unitari.

## A\*

Nell'implementazione di A\*, inizialmente procediamo come nella ricerca in
ampiezza. Per rappresentare gli stati usiamo dei termini composti `nodo(F, C,
Stato, Azioni)`, dove i parametri stanno a indicare:

- `Stato`: La struttura corrente dello stato.
- `Azioni`: La lista di azioni eseguite per arrivare allo stato corrente.
- `C`: La somma dei costi di `Azioni`.
- `F`: Il valore di `C` più l'euristica a partire da `Stato`.

Salviamo i valori `C` ed `F` per poter implementare il criterio di ricerca
dell'algoritmo, ovvero $f(x) = g(x) + h(x)$, dove il valore di $f(x)$
corrisponde a quello di `F`. Per poter ordinare i nodi in base a `F`, lo
poniamo come primo parametro del funtore.

Il corpo dell'algoritmo inizia da `a_star_aux`. Questa regola utilizza 3
parametri:

1. Una lista di nodi da visitare.
2. Una lista di nodi visitati.
3. La soluzione.

```prolog
% a_star_aux(DaVisitare, Visitati, Soluzione)
a_star_aux(
  [nodo(CostoPiuEuristica, Costo, S, Azioni)|Tail],
  Visitati,
  Soluzione
) :-
    ...
```
Per prima cosa cerchiamo tutte le azioni applicabili per lo stato corrente
attraverso il predicato `findall` e le inseriamo nella lista degli applicabili.

In seguito chiamiamo la regola `genera_figli` che genera i figli del nodo
corrente in base agli applicabili trovati. Questi nodi vengono poi inseriti
nella coda dei nodi da visitare.

```prolog
  findall(Applicabile, applicabile(Applicabile, S), ListaApplicabili),
  genera_figli(
    nodo(CostoPiuEuristica, Costo, S, Azioni),
    ListaApplicabili,
    [S|Visitati],
    ListaFigli
  ),
  append(Tail, ListaFigli, NuovaCoda),
```

A questo punto i nodi vengono riordinati tramite `list_to_ord_set`, in modo che
si trovino in ordine crescente rispetto a $f(x)$. Infine richiamiamo
ricorsivamente `a_star_aux` con la nuova lista di nodi da visitare.

```prolog
  list_to_ord_set(NuovaCoda, NuovaCodaOrdinata),
  a_star_aux(NuovaCodaOrdinata, [S|Visitati], Soluzione).
```

Analizziamo ora la regola `genera_figli`. Questa regola contiene 4 parametri:

1. Il nodo di cui calcolare i figli.
2. La lista degli applicabili per lo stato corrente .
3. La lista degli stati già visitati.
4. La lista di output dei figli generati.

Abbiamo scelto di far unificare gli argomenti di `nodo` nel corpo della regola
al fine di renderla più leggibile.

```prolog
genera_figli(
  Nodo,
  [Applicabile|AltriApplicabili],
  Visitati,
  [Figlio|FigliTail]
) :-
  Nodo=nodo(_, Costo, S, AzioniPerS),
  ...
```

La regola applica l'azione in testa alla lista degli applicabili, generando il
nodo figlio, e calcola i suoi valori $g(x)$, $h(x)$ e $f(x)$.

```prolog
  trasforma(Applicabile, S, SNuovo),
  \+ member(SNuovo, Visitati),
  !,
  euristica(SNuovo, Euristica),
  costo(Applicabile, CostoApplicabile),
  CostoFiglio is CostoApplicabile+Costo,
  CostoPiuEuristicaFiglio is CostoFiglio+Euristica,
  Figlio=nodo(
    CostoPiuEuristicaFiglio,
    CostoFiglio,
    SNuovo,
    [Applicabile|AzioniPerS]
  ),
```

La regola viene poi richiamata ricorsivamente per tutte le azioni contenute
nella coda della lista degli applicabili.

```prolog
  genera_figli(Nodo, AltriApplicabili, Visitati, FigliTail).
```

Se l'azione applicabile porta a uno stato già visitato la regola fallirà a
causa del controllo `\+ member(SNuovo, Visitati)`. In questo caso verrà
verificata una seconda clausola di `genera_figli` che procede direttamente
all'elaborazione del figlio successivo. In corrispondenza del controllo abbiamo
inserito un cut in modo tale da non permettere erroneamente backtraking in
questa clausola.

```prolog
genera_figli(Nodo, [_|AltriApplicabili], Visitati, FigliTail) :-
    genera_figli(Nodo, AltriApplicabili, Visitati, FigliTail).
```

