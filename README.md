# Build a Database Lab

Laboratorio didattico pubblico per comprendere progressivamente i principi che
stanno sotto un database.

L'obiettivo non è semplicemente completare un tutorial, ma costruire un percorso
di studio autonomo, rigoroso e tracciabile.

## Stato corrente

| Asse | Stato |
|---|---|
| Repository preparation | Preparation in progress |
| Learner activity | not studied |
| Implementation | not started |
| Verification | not applicable |

**Prepared != Studied.**

La preparazione del repository non costituisce attività di studio.

Nessuna parte del tutorial iniziale è stata ancora marcata come studiata e non
è stata avviata alcuna implementazione.

## Fonte iniziale

La fonte che ha motivato il laboratorio è:

- [Let's Build a Simple Database](https://cstack.github.io/db_tutorial/)

È stata individuata tramite il catalogo pubblico
`practical-tutorials/project-based-learning`.

La fonte esterna viene referenziata e tracciata, non inglobata nel repository.

Consulta:

- [Source policy](sources/README.md)
- [Source coverage](docs/source-coverage/README.md)

## Architettura didattica

Il laboratorio mantiene separati quattro assi:

1. preparazione del repository;
2. attività reale del learner;
3. implementazione;
4. verifica.

I relativi contratti sono documentati in:

- [Architettura didattica](docs/architecture.md)
- [Progress tracking](docs/progress/README.md)
- [Study map](docs/study-map/README.md)

## Aree del repository

- `theory/`: note e spiegazioni originali prodotte durante studio reale;
- `exercises/`: esercizi originali;
- `implementations/`: codice prodotto nel laboratorio;
- `lesson-learned/`: conoscenza consolidata dopo lavoro realmente svolto;
- `sources/`: riferimenti e politica delle fonti;
- `docs/`: architettura, progresso, source coverage e study map;
- `scripts/`: controlli locali di repository hygiene.

Le aree didattiche sono attualmente predisposte ma non contengono attività di
studio o implementazione già svolta.

## Repository hygiene

La validazione locale canonica è:

```bash
scripts/check-repository.sh
```

Il gate destinato alla CI e alla readiness finale è:

```bash
scripts/check-repository.sh --require-prepared
```

Finché la preparazione non è conclusa, il secondo comando deve fallire.

La CI usa lo stesso validator locale e non mantiene una seconda implementazione
delle regole.

## Materiale privato

Eventuale materiale locale o non pubblicabile può essere conservato sotto:

`sources/private/`

Quel percorso è escluso da Git e il validator ne verifica il confine.

## Licenza

Il materiale originale di questo repository è distribuito secondo la
[MIT License](LICENSE).

Le fonti esterne conservano le proprie licenze, attribuzioni e condizioni d'uso.
