# Source coverage

Stato del documento: prepared / structural only

Stato learner: not studied

Questa mappa registra ciò che è stato osservato sulle fonti senza trasformare
la preparazione del repository in studio anticipato.

## Regola fondamentale

La presenza di un argomento nel titolo, nell'indice o nei metadati di una fonte
non dimostra che:

- sia stato studiato;
- sia stato compreso;
- sia stato implementato;
- sia stato verificato;
- sia trattato dalla fonte con profondità sufficiente;
- debba necessariamente entrare nella roadmap del laboratorio.

## Fonte canonica iniziale

ID: SRC-001

Nome: Let's Build a Simple Database

URL canonico: https://cstack.github.io/db_tutorial/

Tipo: tutorial web pubblico

Progetto upstream osservato: `cstack/db_tutorial`

Tecnologia dichiarata dalla fonte: clone di SQLite scritto da zero in C

Licenza osservata sul repository upstream: MIT

Stato upstream osservato: non più in sviluppo attivo

Individuazione iniziale: `practical-tutorials/project-based-learning`

Ruolo di `project-based-learning`: discovery source, non autorità didattica.

## Stato dell'ispezione

Metadati della fonte: observed

Struttura generale / indice: observed

Studio delle lezioni: not started

Valutazione approfondita della copertura: not assessed

Implementazione derivata dalla fonte: none

## Struttura osservata

L'indice pubblico presenta 15 parti numerate.

A livello esclusivamente strutturale, i titoli mostrano un percorso che include
riferimenti a:

- REPL iniziale;
- compilazione SQL e virtual machine;
- database in-memory append-only a tabella singola;
- test e bug;
- persistenza su disco;
- cursor abstraction;
- introduzione e organizzazione di B-Tree;
- binary search e duplicate keys;
- splitting e ricerca del B-Tree;
- gestione di strutture B-Tree multilivello;
- passi successivi.

Questa lista deriva esclusivamente dall'osservazione dell'indice pubblico.

Non rappresenta studio dei contenuti delle parti.

## Copertura didattica iniziale

| Area preliminare del laboratorio | Evidenza dalla fonte | Stato |
|---|---|---|
| rappresentazione dei dati | titolo/indice da valutare | unknown |
| record e righe | titolo/indice da valutare | unknown |
| storage | persistenza indicata nell'indice | title-level observation only |
| pagine | da valutare durante studio reale | unknown |
| parsing | compilazione SQL indicata nell'indice | title-level observation only |
| query | da valutare durante studio reale | unknown |
| esecuzione | virtual machine indicata nell'indice | title-level observation only |
| strutture dati | B-Tree indicato nell'indice | title-level observation only |
| persistenza | indicata esplicitamente nell'indice | title-level observation only |
| organizzazione interna | da valutare durante studio reale | unknown |
| indici | da valutare durante studio reale | unknown |
| error handling | da valutare durante studio reale | unknown |
| testing | test e bug indicati nell'indice | title-level observation only |
| trade-off architetturali | da valutare durante studio reale | unknown |

## Obiettivi aggiuntivi

Gli obiettivi didattici del laboratorio potranno superare la copertura della
fonte canonica.

Quando ciò avverrà, devono essere marcati come obiettivi originali o supportati
da fonti aggiuntive, senza attribuirli artificialmente a SRC-001.
