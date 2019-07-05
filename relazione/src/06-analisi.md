\newpage

# Analisi

Abbiamo confrontato i tre algoritmi su tre domini e utilizzando due euristiche differenti.
I parametri utilizzati per il confronto sono quattro:

- Number of inferences: Il numero di inferenze effettuato dall'algoritmo in un esecuzione
- Execution Time: Tempo di un esecuzione in secondi
- Number of lips: Logical Inferences Per Second
- First Solution length: Il numero di passi presenti nella prima soluzione trovata.

Infine abbiamo confrontato i tre algoritmi su uno stesso dominio ma assegnando alle azioni un costo variabile.

Caratteristiche macchina utilizzata:

* SO Ubuntu 18.04 
* Processore Intel Core i5 5200U
* Frequenza Massima 2,70 GHz
* Chache 3 MB
* RAM 8 GB 

\newpage

## Dominio 1

```{caption="Dominio 1: esempio moodle"}
stato iniziale    stato finale

                   a
 a                 b
 b d               c
 c e               d e
---------------    ------------
```

| Algorithms          | Inferences | Execution Time (s) |    Lips | First Solution length |
| ------------------- | ---------: | -----------------: | ------: | --------------------: |
| Iterative deepening |  3,331,110 |              0.367 | 9077721 |                    12 |
| A\*                 |  2,045,469 |              0,621 | 3292351 |                    12 |
| IDA\*               |  2,862,494 |              0.325 | 8797702 |                    12 |

: Dominio 1, risultati con prima euristica

| Algorithms          | Inferences | Execution Time (s) |    Lips | First Solution length |
| ------------------- | ---------: | -----------------: | ------: | --------------------: |
| Iterative deepening |  3,331,110 |              0.367 | 9077721 |                    12 |
| A\*                 |    174,894 |              0.037 | 4682229 |                    12 |
| IDA\*               |  5,930,528 |              0.651 | 9112884 |                    12 |

: Dominio 1, risultati con seconda euristica

\newpage

## Dominio 2

```{caption="Dominio 2: esempio Prof. Torasso"}
stato iniziale      stato finale

                    a
                    b
                    c
a                   d
b c d e f g h       e
-------------       ------------
```

| Algorithms          |     Inferences | Execution Time (s) |    Lips | First Solution length |
| ------------------- | -------------: | -----------------: | ------: | --------------------: |
| Iterative deepening |  1,536,727,053 |            187.355 | 8202216 |                    10 |
| A\*                 |            N/A |                N/A |     N/A |                   N/A |
| IDA\*               | 10,766,835,266 |           1195.656 | 9004961 |                    10 |

: Dominio 2, risultati con prima euristica

| Algorithms          |     Inferences | Execution Time (s) |    Lips | First Solution length |
| ------------------- | -------------: | -----------------: | ------: | --------------------: |
| Iterative deepening |  1,536,727,053 |            187.355 | 8202216 |                    10 |
| A\*                 |     37,874,888 |             23.033 | 1644371 |                    10 |
| IDA\*               | 10,947,466,831 |           1203.364 | 9097384 |                    10 |

: Dominio 2, risultati con seconda euristica

\newpage

## Dominio 3

```{caption="Dominio 3"}
stato iniziale      stato finale

a   d               b   e
b   e               c   f
c   f               a   d
--------------      ------------
```

| Algorithms          |    Inferences | Execution Time (s) |     Lips | First Solution length |
| ------------------- | ------------: | -----------------: | -------: | --------------------: |
| Iterative deepening |   471,965,663 |             54.858 |  8603383 |                    16 |
| A\*                 |   669,712,233 |            563.830 |  1187792 |                    16 |
| IDA\*               | 1,579,600,374 |            138.929 | 11369810 |                    16 |

: Dominio 3, risultati con prima euristica

| Algorithms          |  Inferences | Execution Time (s) |    Lips | First Solution length |
| ------------------- | ----------: | -----------------: | ------: | --------------------: |
| Iterative deepening | 471,965,663 |             54.858 | 8603383 |                    16 |
| A\*                 |   5,587,396 |              2.168 | 2577590 |                    16 |
| IDA\*               |  74,085,129 |              8.010 | 9249367 |                    16 |

: Dominio 3, risultati con seconda euristica



![Confronto dei risultati per il terzo dominio](Istogrammi/a.png)

##Confronto  euristiche  con costi variabili
Abbiamo assegnato costo 3 alle azioni `stack` e `unstack` e costo 1 alle azioni `putdown` e `pickup`.

: Dominio 3, risultati con prima euristica

| Algorithms |  Inferences | Execution Time (s) |    Lips | First Solution length |
| ---------- | ----------: | -----------------: | ------: | --------------------: |
| A\*        | 658,472,296 |            538.194 | 2577590 |                    16 |
| IDA\*      | 593,054,438 |             69.742 | 8509952 |                    16 |

: Dominio 3, risultati con seconda euristica

| Algorithms |  Inferences | Execution Time (s) |    Lips | First Solution length |
| ---------- | ----------: | -----------------: | ------: | --------------------: |
| A\*        | 283,752,336 |             31.995 | 8868703 |                    16 |
| IDA\*      | 183,414,987 |            136.742 | 1341699 |                    16 |

![Confronto dei risultati per costo variabile](Istogrammi/costi.png)

## Osservazioni
Gli istogrammi riportano le prestazioni degli algoritmi utilizzando le due euristiche.
Il dominio di prova selezionato per la creazione degli istogrammi è il terzo perchè ha una complessità che si pone tra il primo e il secondo dominio.

Osservando le prestazioni degli algoritmi che effettuano una ricerca informata, notiamo come la seconda euristica approssimi molto meglio il numero di passi necessario per trovare la soluzione.
Vediamo infatti una diminuzione significativa del numero di inferenze effettuate e quindi una diminuzione del tempo di esecuzione totale:

|      | Execution Time (Euristica 1) | Execution Time (Euristica 2) |
| ---- | ---------------------------: | ---------------------------: |
| A*   |           $\approx$ 9 minuti |        $\approx$   1.8 secondi |
| IDA* |         $\approx$ 2,3 minuti |        $\approx$   7.8 secondi |

Il tempo d'esecuzione dell'iterative deepening nel dominio tre è di $\approx$ 1 minuto, quindi si comporta meglio degli algoritmi a ricerca informata nel caso della prima euristica ma peggio nel caso della seconda euristica.

Questo dimostra come la prima euristica sia decisamente poco efficace. Di fatto rende i due algoritmi basati su ricerca informata meno efficenti di un algoritmo di ricerca non informata.

Per quanto riguarda il confronto degli algoritmi a ricerca informata per costi differenti, notiamo come questo causi un ribaltamento delle prestazioni tra i due algoritmi.
Infatti utilizzando la prima euristica,  `A*` risulta più efficente di `IDA*`,utilizzando la seconda accade esattamente il contrario.

Infine notiamo come aumentando il costo di determinate azioni, gli algoritmi a ricerca informata funzionino leggermente meglio utilizzando la prima euristica ma peggiorino decisamente utilizzando la seconda.

Un ultima osservazione va fatta riguardo le dimensioni e le complessità dei domini testati. Le relazioni ottenute tra gli algoritmi per il dominio 3 si mantengono per tutti i domini ad eccezione del dominio due, ovvero il più complesso.

In questo caso, per quanto riguarda la prima euristica, non siamo riusciti ad ottenere dati riguardo l'algoritmo `A*`. l'esecuzione infatti è terminata a  causa dell'esaurimento della memoria.

Per quanto riguarda l'utilizzo della seconda euristica invece, vediamo come `IDA*` abbia prestazioni stranamente peggiori tra tutti gli algoritmi, con un tempo di esecuzione di ben $\approx$ 20 minuti.

fare media eurisica due dominio tre.
controllare ida*  euristica due, dominio 2.

