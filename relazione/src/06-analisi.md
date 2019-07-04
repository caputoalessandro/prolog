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

| Algorithms          | Number of Inferences | Execution Time (s) | Lips    | First Solution length |
| ------------------- | -------------------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 3,331,110            | 0.367              | 9077721 | 12                    |
| A*                  | 2,045,469            | 0,621              | 3292351 | 12                    |
| IDA*                | 2,862,494            | 0.325              | 8797702 | 12                    |

**Dominio 2**

| Algorithms          | Number of Inferences | Execution Time (s) | Lips    | First Solution length |
| ------------------- | -------------------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 1,536,727,053        | 187.355            | 8202216 | 10                    |
| A*                  | ?                    | ?                  | ?       | ?                     |
| IDA*                | 10,766,835,266       | 1195.656           | 9004961 | 10                    |

**Dominio 3**

| Algorithms          | Number of Inferences | Execution Time (s) | Lips    | First Solution length |
| ------------------- | -------------------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 471,965,663          | 54.858             | 8603383 | 16                    |
| A*                  | 669,712,233          | 563.830            | 1187792 | 16                    |
| IDA*                |                      |                    |         |                       |

## Euristica 2

**Dominio 1**

| Algorithms          | Number of Inferences | Execution Time (s) | Lips    | First Solution length |
| ------------------- | -------------------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 3,331,110            | 0.367              | 9077721 | 12                    |
| A*                  |                      |                    |         |                       |
| IDA*                |                      |                    |         |                       |

**Dominio 2**

| Algorithms          | Number of Inferences | Execution Time (s) | Lips    | First Solution length |
| ------------------- | -------------------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 1,536,727,053        | 187.355            | 8202216 | 10                    |
| A*                  |                      |                    |         |                       |
| IDA*                |                      |                    |         |                       |

**Dominio 3**

| Algorithms          | Number of Inferences | Execution Time (s) | Lips | First Solution length |
| ------------------- | -------------------- | ------------------ | ---- | --------------------- |
| Iterative deepening |                      |                    |      |                       |
| A*                  |                      |                    |      |                       |
| IDA*                |                      |                    |      |                       |

## Costo variabile

Calcolato sul terzo dominio
| Algorithms          | Number of Inferences | Execution Time (s) | Lips | First Solution length |
| ------------------- | -------------------- | ------------------ | ---- | --------------------- |
| Iterative deepening |                      |                    |      |                       |
| A*                  |                      |                    |      |                       |
| IDA*                |                      |                    |      |                       |