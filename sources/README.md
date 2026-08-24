# Sources policy

Questa directory registra fonti esterne, riferimenti bibliografici e metadati
utili al percorso di studio.

Non è un archivio del materiale sorgente.

## Principio

Una fonte esterna deve essere referenziata e attribuita senza trasformare il
repository in una sua copia.

La disponibilità pubblica o la licenza di una fonte non annullano questa regola
didattica: il laboratorio deve produrre comprensione e materiale originale,
non replicare il percorso sorgente.

## Contenuto pubblico ammesso

Il repository può contenere:

- nome e autore/progetto della fonte;
- URL canonici;
- riferimenti a sezioni o argomenti osservati;
- informazioni di licenza verificate;
- brevi note sulla provenienza;
- appunti e spiegazioni originali;
- diagrammi originali;
- esercizi originali;
- implementazioni originali;
- Lesson Learned derivanti da lavoro realmente svolto.

## Contenuto da non inglobare

Non devono essere copiati automaticamente nel repository:

- tutorial completi;
- trascrizioni integrali;
- copie massive di pagine web;
- repository upstream importati come materiale didattico;
- libri, PDF o ebook protetti;
- raccolte sostanziali di codice sorgente esterno;
- materiale privato o personale.

## Materiale privato

Eventuale materiale locale o privato deve vivere sotto:

`sources/private/`

Il percorso deve restare escluso dal versionamento Git.

## Classificazione dei materiali

### Source material

Materiale prodotto da terzi.

Per impostazione predefinita resta esterno e viene rappresentato tramite
riferimenti e metadati.

### Personal notes / theory

Spiegazioni, schemi e note originali prodotti durante studio realmente svolto.

Quando derivano da una fonte, devono indicarla chiaramente.

### Exercises

Esercizi originali preparati nel laboratorio.

Un esercizio preparato non è automaticamente un esercizio svolto.

### Implementation

Codice scritto nel laboratorio durante attività reale di implementazione.

La presenza di codice non implica verifica.

### Lesson Learned

Conoscenza consolidata dopo studio, implementazione, verifica o analisi
realmente svolti.

Non vengono create Lesson Learned preventive o fittizie.

## Materiale derivato

Quando un contenuto è adattato o derivato da una fonte esterna, deve essere
esplicitato.

Distinguere sempre tra:

- osservazione della fonte;
- materiale derivato o adattato;
- interpretazione originale;
- implementazione originale del laboratorio.
