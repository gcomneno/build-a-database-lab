# Architettura didattica

## Scopo

`build-a-database-lab` è un laboratorio pubblico per studiare in modo progressivo
i principi interni dei database.

L'obiettivo non è riprodurre un tutorial né dichiararne il completamento, ma
costruire un percorso didattico autonomo, tracciabile e verificabile.

## Separazione degli stati

Il repository mantiene distinti quattro assi:

### Repository preparation

Stati:

- `Preparation in progress`
- `Prepared`

Descrive esclusivamente la readiness dell'ambiente didattico.

### Learner activity

Stati:

- `not studied`
- `studying`
- `studied`

Descrive esclusivamente attività di studio realmente svolta.

### Implementation

Stati:

- `not started`
- `partial`
- `implemented`

Descrive esclusivamente codice realmente prodotto nel laboratorio.

### Verification

Stati:

- `not applicable`
- `not run`
- `partial`
- `verified`

`not applicable` è ammesso quando non esiste ancora un'implementazione da
verificare.

## Invarianti

Devono restare sempre vere le seguenti distinzioni:

- Prepared != Studied
- Studied != Implemented
- Implemented != Verified

La creazione di file, mappe, esercizi o infrastruttura non fa avanzare
automaticamente nessun altro asse.

## Fonti esterne

Le fonti esterne guidano lo studio ma non diventano contenuto del repository.

Il repository deve preferire:

- riferimenti e URL canonici;
- metadati sulle fonti;
- appunti originali;
- spiegazioni originali;
- esercizi originali;
- implementazioni originali;
- Lesson Learned derivanti da lavoro realmente svolto.

Non deve diventare un mirror del materiale sorgente.

## Confini iniziali

In questa fase:

- non viene studiato il tutorial;
- non viene scelta una toolchain di implementazione;
- non viene scritto codice database;
- non viene dichiarata copertura didattica non verificata;
- non vengono prodotte Lesson Learned fittizie.
