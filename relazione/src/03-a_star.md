# A-Star

Il corpo dell'algoritmo inizia dalla regola **A_star_aux**, questa regola ha come parametri una lista con il nodo corrente da visitare in testa e tutti i nodi restanti da visitare sulla coda, inoltre contiene i nodi visitati e la soluzione.
Per prima cosa attraverso la funzione _findall_ cerchiamo tutte le azioni applicabili per lo stato _S_ e le inseriamo in _ListaApplicabili_, in seguito chiamiamo la regola _GeneraFigli_ dandogli in input il _nodo corrente_ (contenente il valore g(n) + h(n)) e la lista degli applicabili, la funzione genererà tutti i figli del nodo corrente che verranno inseriti attraverso una _append_ sulla coda della lista dei nodi da visitare.
A questo punto ordiniamo la lista attraverso _List_to_ord_set_ e richiamiamo A_star_aux inserendo la nuova lista di nodi da visitare.
