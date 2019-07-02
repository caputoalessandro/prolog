# A\*

Nell'implementazione di A\*, inizialmente procediamo come nella ricerca in
ampiezza. Per rappresentare gli stati usiamo dei funtori di tipo `nodo(F, C,
Stato, Azioni)`, dove i parametri stanno a indicare:

- `Stato`: La struttura corrente dello stato.
- `Azioni`: La lista di azioni eseguite per arrivare allo stato corrente.
- `C`: La somma dei costi di `Azioni`.
- `F`: Il valore di `C` più l'euristica a partire da `Stato`.

Per poter ordinare i nodi in base a `F`, lo poniamo come primo parametro del
funtore.

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
genera_figli(nodo(CostoPiuEuristica, Costo, S, Azioni),
             ListaApplicabili,
             [S|Visitati],
             ListaFigli),
append(Tail, ListaFigli, NuovaCoda),
list_to_ord_set(NuovaCoda, ListaOrdinata),
a_star_aux(ListaOrdinata, [S|Visitati], Soluzione).
```

A questo punto ordiniamo i nodi nella lista in ordine di costo crescente
attraverso `list_to_ord_set`. Infine richiamiamo `a_star_aux` inserendo la
nuova lista di nodi da visitare.

Analizziamo ora la regola `genera_figli`. Questa regola contiene 4 parametri:

1. Il nodo di cui calcolare i figli.
2. La lista degli applicabili per lo stato corrente .
3. La lista degli stati già visitati.
4. La lista di output dei figli generati.

Dopo aver applicato l'azione in testa alla lista degli applicabili la regola
ottiene il nuovo stato e genera il nodo figlio. Vengono quindi calcolati il
nuovi valori di $g(n)$, $h(n)$ e $f(n)$.

Abbiamo deciso di far unificare il nodo corrente e il nodo figlio con le
seguenti variabili al fine di rendere più leggibile la regola.

```prolog
Nodo=nodo(_, Costo, S, AzioniPerS),
```

La regola viene poi richiamata ricorsivamente per tutte le azioni contenute
nella coda della lista degli applicabili.

Se l'azione applicabile porta a uno stato già visitato la regola fallirà a
causa del controllo `member(SNuovo, Visitati)`. In questo caso verrà
verificata una seconda regola `genera_figli` che si richiamerà ricorsivamente
applicando l'azione successiva.

```prolog
genera_figli(nodo(CostoPiuEuristica, Costo, S, AzioniPerS), [_|AltriApplicabili], Visitati, FigliTail) :-
    genera_figli(nodo(CostoPiuEuristica, Costo, S, AzioniPerS),
                 AltriApplicabili,
                 Visitati,
                 FigliTail).
```

In corrispondenza del controllo `member(SNuovo, Visitati)` abbiamo inserito
un cut in modo tale da non fare backtraking verificando erroneamente la
seconda regola `genera_figli`.
