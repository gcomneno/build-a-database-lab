# Study map

Stato del documento: draft / prepared

Stato learner: not studied

Questa mappa organizza possibili direzioni di studio del laboratorio.

Non rappresenta:

- contenuto già studiato;
- copertura confermata della fonte canonica;
- una sequenza definitiva;
- attività già implementata;
- attività già verificata.

La sequenza potrà cambiare quando lo studio reale e la source coverage
produrranno evidenze migliori.

## Principi

La study map deve:

- privilegiare comprensione dei principi rispetto al completamento meccanico
  di un tutorial;
- rendere esplicite le dipendenze concettuali;
- distinguere teoria, implementazione e verifica;
- permettere approfondimenti aggiuntivi rispetto alla fonte iniziale;
- evitare di attribuire alla fonte argomenti non ancora verificati;
- produrre Lesson Learned soltanto dopo lavoro realmente svolto.

## Area 1 - Fondamenti

Possibili temi:

- rappresentazione dei dati;
- record e righe;
- relazione tra rappresentazione logica e fisica;
- organizzazione dello storage;
- persistenza;
- pagine e unità di memorizzazione;
- strutture dati utilizzate internamente.

Stato: not studied

Copertura SRC-001: da determinare tramite studio reale.

## Area 2 - Dal testo all'esecuzione

Possibili temi:

- input e comandi;
- parsing;
- rappresentazione delle istruzioni;
- query;
- separazione tra parsing ed esecuzione;
- modello di esecuzione;
- error handling.

Stato: not studied

Copertura SRC-001: da determinare tramite studio reale.

## Area 3 - Organizzazione e accesso ai dati

Possibili temi:

- ricerca dei record;
- cursori e navigazione;
- organizzazione interna dei dati;
- strutture ad albero;
- indici;
- inserimento e aggiornamento delle strutture;
- trade-off tra semplicità, memoria e prestazioni.

Stato: not studied

Copertura SRC-001: da determinare tramite studio reale.

## Area 4 - Implementazione

Questa area raccoglierà attività di programmazione soltanto quando saranno
realmente iniziate.

Possibili attività future:

- piccoli esperimenti isolati;
- implementazioni progressive;
- confronto tra alternative;
- refactoring motivati da evidenze;
- osservazione del comportamento reale del codice.

Stato implementation: not started

Nessun linguaggio, toolchain o build system è ancora una scelta canonica del
laboratorio.

La tecnologia utilizzata da una fonte esterna non determina automaticamente
la tecnologia del laboratorio.

## Area 5 - Verification and testing

Possibili temi:

- test di comportamento;
- casi limite;
- persistenza tra esecuzioni;
- errori e input invalidi;
- invarianti delle strutture dati;
- regressioni;
- confronto tra comportamento atteso e osservato;
- limiti conosciuti dell'implementazione.

Stato verification: not applicable

La verifica diventerà applicabile soltanto quando esisterà qualcosa da
verificare.

## Area 6 - Approfondimenti futuri

Argomenti non necessari al percorso iniziale potranno essere aggiunti quando
motivato da:

- domande emerse durante lo studio;
- limiti della fonte canonica;
- comportamento osservato nell'implementazione;
- necessità di una fonte aggiuntiva;
- confronto con database reali.

La presenza di un argomento in questa area non implica che debba essere
studiato.

## Relazione con la source coverage

La study map descrive ciò che il laboratorio potrebbe voler comprendere.

La source coverage descrive invece ciò che le fonti supportano effettivamente.

Le due mappe non devono essere confuse.

In particolare:

Study goal != Source coverage

Source coverage != Studied

Studied != Implemented

Implemented != Verified
