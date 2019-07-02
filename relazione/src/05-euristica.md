\newpage

# Funzioni euristiche

Abbiamo implementato e confrontato due euristiche differenti, nella
formulazione delle euristiche siamo partiti da un concetto di fondo, ovvero il
confronto tra lo stato finale e lo stato iniziale. Dopo aver effettuato delle
ricerche abbiamo deciso di implementare le seguenti euristiche:

**Euristica 1**: Calcolare il numero di blocchi correnti che non sono nella
posizione corretta

**Euristica 2**: Calcolare la differenza tra stato corrente e stato finale
considerando la posizione di ogni blocco rispetto al blocco sottostante e
sovrastante. Se il blocco A nello stato finale dovrebbe trovarsi sopra il
blocco B e sotto il blocco C e nello stato corrente si trova sotto il blocco B
e sopra il blocco C allora bisogna aggiungere il valore 2 all'euristica.

L'idea è quella di considerare il risultato della sottrazione tra l'insieme dei
fatti che descrivono lo stato finale e l'insieme dei fatti che descrivono lo
stato finale, in modo da ottenere tutti i fatti che differiscono tra i due
stati.

Abbiamo considerato solo i fatti *ontable(X,Y)* e *on(X)* poiché i fatti
*clear* ci danno delle informazioni supreflue sulle differenze tra stato
iniziale e stato finale.

## Euristica 1

La regola ha due parametri, la soglia attuale e una variabile in cui inseriremo
il valore dell'euristica calcolato. Per prima cosa effettuiamo la sottrazione
tra insiemi attraverso la funzione `ord_subtract`, successivamente contiamo le
occorrenze dei fatti che ci interessano attraverso la funzione *include*.

Abbiamo inserito inoltre due fatti che ci hanno permesso di inserire un unico
parametro nella funzione *include* al fine di selezionare sia i fatti *on* che
i fatti *ontable*.

``` {.prolog}
is_on(on(_,_)).
is_on(ontable(_)).
```

Infine inseriamo il risultato in una variabile utilizzando la funzione `max`,
questo per evitare che l'algoritmo ricada in un ciclo infinito nel caso in cui
il valore dell'euristica fosse 0.

## Euristica 2

``` {.prolog}
euristica(StatoAttuale, Valore) :-
    goal(StatoFinale),
    ord_subtract(StatoFinale, StatoAttuale, DifferenzaStati),
    include(is_on, DifferenzaStati, StatiOn),
    include(is_ontable, DifferenzaStati, StatiOntable),
    length(StatiOn, LunghezzaStatiOn),
    length(StatiOntable, LunghezzaStatiOntable),
    ValoreOn is LunghezzaStatiOn * 2,
    ValoreTable is LunghezzaStatiOntable,
    Valore is ValoreOn + ValoreTable.
```

L'implementazione della seconda euristica è molto simile a quella della prima,
di fatto ci è bastato contare due volte il numero dei fatti `on` ottenuti dalla
sottrazione degli insiemi. L'idea è quella di contare tutti i fatti on in cui è
presente un determinato cubo, quindi se nell'insieme della sottrazione ci fosse
on(A,B) on(C,B) conteremmo due volte per il cubo B, una volta per il cubo A e
una volta per il cubo C. Tutto ciò equivale a contare sempre due volte ogni
`on` visto che in ognuno di questi fatti si trovano sempre due cubi differenti.
