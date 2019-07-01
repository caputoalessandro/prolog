
# A-Star

Il corpo dell'algoritmo inizia da **A_star_aux**.

Questa regola utilizza 3 parametri:

1. Una lista dove in testa c'è il nodo corrente da visitare e in coda tutti i nodi restanti da visitare.
2. Una lista contenente i nodi visitati  
3. Soluzione.

Per prima cosa attraverso la funzione _findall_ cerchiamo tutte le azioni applicabili per lo stato corrente e le inseriamo nella lista degli applicabili.

In seguito chiamiamo la regola _GeneraFigli_ che genererà tutti i figli del nodo corrente. Attraverso la funzione *append*  i figli generati verranno inseriti sulla coda della lista dei nodi da visitare.

A questo punto ordiniamo la lista attraverso _List_to_ord_set_ in modo da ordinare i nodi in ordine di costo crescente. infine richiamiamo A_star_aux inserendo la nuova lista di nodi da visitare.

Analizziamo ora la regola **Genera_figli**

Questa regola contiene 4 parametri:

1. il nodo del quale dovrà calcolare i figli
2. la lista degli applicabili per lo  stato corrente  
3. La lista degli stati già visitati 
4. la lista in cui inserirà i figli generati.

Dopo aver applicato l'azione in testa alla lista degli applicabili la regola otterà il nuovo stato e genererà il nodo figlio.
Saranno calcolati quindi il nuovi valori di g(n), h(n) e F(n).

Abbiamo deciso di far unificare il nodo corrente e il nodo figlio con le seguenti variabili solo al fine di rendere più leggibile la regola.

* Nodo=nodo(_, Costo, S, AzioniPerS) 
* Figlio=nodo(CostoPiuEuristicaFiglio, CostoFiglio, SNuovo, [Applicabile|AzioniPerS]).

La regola verrà  infine richiamata ricorsivamente per tutte le azioni contenute nella coda della lista degli applicabili.

Se l'azione applicabile porta a  uno stato già visitato la regola fallirà a causa del controllo *member(SNuovo, Visitati)*. In questo caso verrà verificata una seconda  regola *genera_figli* che si richiamerà ricorsivamente applicando l'azione successiva.

In corrispondenza del controllo *member(SNuovo, Visitati)* abbiamo inserito un *cut* in modo tale da non fare backtraking verificando erroneamente la seconda regola Genera_figli.