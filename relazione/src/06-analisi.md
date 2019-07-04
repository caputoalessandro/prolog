\newpage

# Analisi

Abbiamo confrontato i tre algoritmi su tre domini e utilizzando due euristiche differenti.
I parametri utilizzati per il confronto sono quattro:

- Number of inferences: Il numero di inferenze effettuato dall'algoritmo in un esecuzione
- Execution Time: Tempo di un esecuzione in secondi
- Number of lips: Logical Inferences Per Second
- First Solution length: Il numero di passi presenti nella prima soluzione trovata.

Infine abbiamo confrontato i tre algoritmi su uno stesso dominio ma assegnando alle azioni un costo variabile.

Intel Core i5 5200U 2,70 GHz 8GB RAM

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

| Algorithms          | Inferences | Execution Time (s) | Lips    | First Solution length |
| ------------------- | ---------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 3,331,110  | 0.367              | 9077721 | 12                    |
| A\*                 | 2,045,469  | 0,621              | 3292351 | 12                    |
| IDA\*               | 2,862,494  | 0.325              | 8797702 | 12                    |

: Dominio 1, risultati con prima euristica

| Algorithms          | Inferences | Execution Time (s) | Lips    | First Solution length |
| ------------------- | ---------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 3,331,110  | 0.367              | 9077721 | 12                    |
| A\*                 | 174,894    | 0.037              | 4682229 | 12                    |
| IDA\*               | 5,930,528  | 0.651              | 9112884 | 12                    |

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

| Algorithms          | Inferences     | Execution Time (s) | Lips    | First Solution length |
| ------------------- | -------------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 1,536,727,053  | 187.355            | 8202216 | 10                    |
| A\*                 | N/A            | N/A                | N/A     | N/A                   |
| IDA\*               | 10,766,835,266 | 1195.656           | 9004961 | 10                    |

: Dominio 2, risultati con prima euristica

| Algorithms          | Inferences     | Execution Time (s) | Lips    | First Solution length |
| ------------------- | -------------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 1,536,727,053  | 187.355            | 8202216 | 10                    |
| A\*                 | 37,874,888     | 23.033             | 1644371 | 10                    |
| IDA\*               | 10,947,466,831 | 1203.364           | 9097384 | 10                    |

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

| Algorithms          | Inferences    | Execution Time (s) | Lips     | First Solution length |
| ------------------- | ------------- | ------------------ | -------- | --------------------- |
| Iterative deepening | 471,965,663   | 54.858             | 8603383  | 16                    |
| A\*                 | 669,712,233   | 563.830            | 1187792  | 16                    |
| IDA\*               | 1,579,600,374 | 138.929            | 11369810 | 16                    |

: Dominio 3, risultati con prima euristica

| Algorithms          | Inferences  | Execution Time (s) | Lips    | First Solution length |
| ------------------- | ----------- | ------------------ | ------- | --------------------- |
| Iterative deepening | 471,965,663 | 54.858             | 8603383 | 16                    |
| A\*                 | 5,587,396   | 2.168              | 2577590 | 16                    |
| IDA\*               | 74,085,129  | 8.010              | 9249367 | 16                    |

: Dominio 3, risultati con seconda euristica
