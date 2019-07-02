# A\*

Nell'implementazione di A\*, inizialmente procediamo come nella ricerca in
ampiezza. Per rappresentare gli stati usiamo dei funtori di tipo `nodo(F, C,
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

1. Una lista dove in testa c'è il nodo corrente da visitare e in coda tutti i
   nodi restanti da visitare.
2. Una lista contenente i nodi visitati.
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
attraverso la funzione `findall` e le inseriamo nella lista degli applicabili.

In seguito chiamiamo la regola `genera_figli` che genera tutti i figli del
nodo corrente. Questi vengono poi inseriti nella coda dei nodi da visitare.

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

A questo punto ordiniamo i nodi nella coda attraverso `list_to_ord_set`. Infine
richiamiamo ricorsivamente `a_star_aux` con la nuova lista di nodi da visitare.

```prolog
  list_to_ord_set(NuovaCoda, NuovaCodaOrdinata),
  a_star_aux(NuovaCodaOrdinata, [S|Visitati], Soluzione).
```

Analizziamo ora la regola `genera_figli`. Questa regola contiene 4 parametri:

1. Il nodo di cui calcolare i figli.
2. La lista degli applicabili per lo stato corrente .
3. La lista degli stati già visitati.
4. La lista di output dei figli generati.

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

Abbiamo deciso di far unificare gli argomenti all'interno dei nodi nel corpo
della regola al fine di renderla più leggibile.

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

La regola applica l'azione in testa alla lista degli applicabili, generando il
nodo figlio, e calcola i nuovi valori di $g(n)$, $h(n)$ e $f(n)$.

La regola viene poi richiamata ricorsivamente per tutte le azioni contenute
nella coda della lista degli applicabili.

```prolog
  genera_figli(Nodo, AltriApplicabili, Visitati, FigliTail).
```

Se l'azione applicabile porta a uno stato già visitato la regola fallirà a
causa del controllo `\+ member(SNuovo, Visitati)`. In questo caso verrà
verificata una seconda clausola di `genera_figli` che procede direttamente alla
computazione dell'azione successiva.

```prolog
genera_figli(Nodo, [_|AltriApplicabili], Visitati, FigliTail) :-
    genera_figli(Nodo, AltriApplicabili, Visitati, FigliTail).
```

In corrispondenza del controllo `member(SNuovo, Visitati)` abbiamo inserito
un cut in modo tale da non fare erroneamente backtraking nella seconda
clausola.
