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
sovrastante. Se il blocco `A` nello stato finale dovrebbe trovarsi sopra il
blocco `B` e sotto il blocco `C` e nello stato corrente si trova sotto il blocco `B`
e sopra il blocco `C` allora bisogna aggiungere il valore 2 all'euristica.

## Implementazione

L'idea è quella di considerare il risultato della sottrazione tra l'insieme dei
fatti che descrivono lo stato finale e l'insieme dei fatti che descrivono lo
stato iniziale, in modo da ottenere tutti i fatti che differiscono tra i due
stati.

Abbiamo considerato solo i fatti `ontable(X,Y)` e `on(X)`
poiché i fatti `clear` ci danno delle informazioni superflue sulle differenze tra stato iniziale e stato finale. 

### Euristica 1 

```prolog
euristica(StatoAttuale, Valore) :-
    goal(StatoFinale),
    ord_subtract(StatoFinale, StatoAttuale, DifferenzaStati),
    include(is_on, DifferenzaStati, StatiOn),
    length(StatiOn, LunghezzaStatiOn),
    Valore is max(1,LunghezzaStatiOn).

```

La regola ha due parametri, la soglia attuale e una variabile in cui inseriamo il valore dell'euristica calcolato. Per prima cosa effettuiamo la sottrazione tra insiemi attraverso la funzione `ord_subtract`,  successivamente selezioniamo i fatti che ci interessano (tutti tranne i `clear`) utilizzando la funzione `include`.

Abbiamo inserito inoltre due fatti che ci hanno permesso di inserire un unico parametro nella funzione `include` al fine di selezionare sia i fatti `on` che  i fatti `ontable`.

``` {.prolog}
is_on(on(_,_)).
is_on(ontable(_)).
```

Infine inseriamo il risultato in una variabile utilizzando la funzione `max`, questo per evitare che l'algoritmo ricada in un ciclo infinito nel caso in cui il valore dell'euristica fosse 0.

### Euristica 2

``` {.prolog}
euristica(StatoAttuale, Valore) :-
    goal(StatoFinale),
    ord_subtract(StatoFinale, StatoAttuale, DifferenzaStati),
    include(is_on, DifferenzaStati, StatiOn),
    include(is_ontable, DifferenzaStati, StatiOntable),
    length(StatiOn, LunghezzaStatiOn),
    length(StatiOntable, LunghezzaStatiOntable),
    ValoreOn is LunghezzaStatiOn ` 2,
    ValoreTable is LunghezzaStatiOntable,
    Valore is ValoreOn + ValoreTable.
```
L'implementazione della seconda euristica è molto simile a quella della prima. Di fatto ci è bastato incrementare di due il valore dell'euristica per ogni fatto `on` presente nell'insieme risultante dalla sottrazione dei due insiemi.

La strategia è quella di contare tutti  i fatti `on` riguardanti un determinato cubo. Se nell'insieme risultante da `ordsubtract` ci fosse `on(A,B) on(C,B)` l'euristica incrementerebbe di due a causa del cubo `B`, perché si troverebbe nella posizione errata sia rispetto al cubo sovrastante sia rispetto al cubo sottostante.
Successivamente incrementerebbe di uno per il cubo `A` e ancora di uno per il cubo `C`.
Dal momento che ogni fatto `on` si riferisce a due cubi distinti ci basta incrementare l'euristica di due per ognuno dei fatti `on`  presenti nell'insieme risultante dalla sottrazione.

## Analisi
Abbiamo confrontato i tre algoritmi su tre domini e utilizzando due euristiche differenti.
I parametri utilizzati per il confronto sono quattro:

* Number of  inferences: Il numero di inferenze effettuato dall'algoritmo in un esecuzione
* Execution Time: Tempo di un esecuzione in secondi
* Number of lips: Logical Inferences Per Second
* First Solution length: Il numero di passi presenti nella prima soluzione trovata.

Infine abbiamo confrontato i tre algoritmi su uno stesso dominio ma assegnando alle azioni un costo variabile.

```
Dominio 1: esempio moodle

stato iniziale    stato finale

                   a
 a                 b
 b d               c
 c e               d e
---------------    ------------
```
```
Dominio 2: esempio Prof. Torasso

stato iniziale      stato finale

                       
                    a
                    b
                    c
a                   d
b c d e f g h       e
-------------       ------------
```
```
Dominio 3: esempio inventato

stato iniziale      stato finale

a   d               b   e
b   e               c   f   
c   f               a   d
--------------      ------------
```
## Euristica 1
Intel Core i5 5200U 2,70 GHz 8GB RAM

**Dominio 1**

| Algorithms           |Number of Inferences  | Execution Time (s)  | Lips                    | First Solution length |
|---                   |---                   |---                  |---                      |---                    |
| Iterative deepening  |3,331,110             |0.367                |9077721                  |12                     |
| A*                   |2,045,469             |0,621                |3292351                  |12                     |
| IDA*                 |2,862,494             |0.325                |8797702                  |12                     |

**Dominio 2**

| Algorithms           |Number of Inferences  | Execution Time (s)  | Lips          | First Solution length |
|---                   |---                   |---                  |---            |---                    |
| Iterative deepening  |1,536,727,053         |187.355              |8202216        |10                     |
| A*                   |?                     |?                    |?              |?                      |
| IDA*                 |10,766,835,266        |1195.656             |9004961        |10                     |

**Dominio 3**

| Algorithms           |Number of Inferences  | Execution Time (s)  | Lips                    | First Solution length |
|---                   |---                   |---                  |---                      |---                    |
| Iterative deepening  |                      |                     |                         |                       |
| A*                   |           |              |                 |                     |
| IDA*                 |         |              |                 |                     |

## Euristica 2

**Dominio 1**

| Algorithms           |Number of Inferences  | Execution Time (s)  | Lips                    | First Solution length |
|---                   |---                   |---                  |---                      |---                    |
| Iterative deepening  |3,331,110             |0.367                |9077721                  |12                     |
| A*                   |             |                |                 |                     |
| IDA*                 |             |                |                  |                    |

**Dominio 2**

| Algorithms           |Number of Inferences  | Execution Time (s)  | Lips          | First Solution length |
|---                   |---                   |---                  |---                      |---                    |
| Iterative deepening  |1,536,727,053         |187.355              |8202216        |10                     |
| A*                   |             |               |                  |                    |
| IDA*                 |            |                |                  |                     |

**Dominio 3**

| Algorithms           |Number of Inferences  | Execution Time (s)  | Lips          | First Solution length |
|---                   |---                   |---                  |---                      |---                    |
| Iterative deepening  |                      |                     |                         |                       |
| A*                   |            |                |                  |                     |
| IDA*                 |            |                |                  |                    |

## Costo variabile

Calcolato sul terzo dominio
| Algorithms           |Number of Inferences  | Execution Time (s)  | Lips          | First Solution length |
|---                   |---                   |---                  |---                      |---                    |
| Iterative deepening  |                      |                     |                         |                       |
| A*                   |             |                |                 |                     |
| IDA*                 |             |                |                 |                    |