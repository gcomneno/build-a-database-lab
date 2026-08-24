#!/usr/bin/env bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT" || {
    printf '%s\n' "ERRORE: impossibile entrare nella root del repository."
    exit 1
}

require_prepared=0

for arg in "$@"; do
    case "$arg" in
        --require-prepared)
            require_prepared=1
            ;;
        *)
            printf 'ERRORE: argomento non riconosciuto: %s\n' "$arg"
            exit 2
            ;;
    esac
done

failures=0

ok() {
    printf 'OK: %s\n' "$1"
}

fail() {
    printf 'ERRORE: %s\n' "$1"
    failures=$((failures + 1))
}

check_file() {
    path="$1"

    if [ -f "$path" ]; then
        ok "file presente: $path"
    else
        fail "file mancante: $path"
    fi
}

check_dir() {
    path="$1"

    if [ -d "$path" ]; then
        ok "directory presente: $path"
    else
        fail "directory mancante: $path"
    fi
}

section_state() {
    file="$1"
    heading="$2"

    awk -v heading="$heading" '
        $0 == heading {
            in_section = 1
            next
        }

        in_section && /^## / {
            exit
        }

        in_section && /^Stato corrente: / {
            sub(/^Stato corrente: /, "")
            print
            exit
        }
    ' "$file"
}

check_section_state() {
    file="$1"
    heading="$2"
    expected="$3"

    actual="$(section_state "$file" "$heading")"

    if [ "$actual" = "$expected" ]; then
        ok "$heading = $expected"
    else
        fail "$heading: atteso '$expected', trovato '${actual:-<assente>}'"
    fi
}

check_only_readme() {
    directory="$1"

    extra="$(
        find "$directory" \
            -mindepth 1 \
            -type f \
            ! -name README.md \
            -print 2>/dev/null
    )"

    if [ -z "$extra" ]; then
        ok "$directory contiene solo il contratto README"
    else
        printf '%s\n' "$extra"
        fail "$directory contiene materiale reale non compatibile con lo stato iniziale"
    fi
}

printf '\n===== STRUTTURA CANONICA =====\n'

check_file README.md
check_file LICENSE
check_file .editorconfig
check_file .gitattributes
check_file .gitignore

check_file docs/README.md
check_file docs/architecture.md
check_file docs/progress/README.md
check_file docs/source-coverage/README.md
check_file docs/study-map/README.md

check_file sources/README.md
check_file theory/README.md
check_file exercises/README.md
check_file implementations/README.md
check_file lesson-learned/README.md

check_dir scripts
check_file scripts/check-repository.sh
check_file scripts/check-markdown-links.py

printf '\n===== CONTRATTO DEGLI STATI =====\n'

state_marker_count="$(
    grep -c '^Stato corrente: ' docs/progress/README.md 2>/dev/null
)"

if [ "$state_marker_count" -eq 4 ]; then
    ok "docs/progress/README.md contiene esattamente quattro stati canonici"
else
    fail "docs/progress/README.md deve contenere esattamente quattro marker 'Stato corrente:'"
fi

if [ "$require_prepared" -eq 1 ]; then
    check_section_state \
        docs/progress/README.md \
        "## Repository preparation" \
        "Prepared"
else
    preparation_state="$(
        section_state \
            docs/progress/README.md \
            "## Repository preparation"
    )"

    case "$preparation_state" in
        "Preparation in progress"|"Prepared")
            ok "## Repository preparation = $preparation_state"
            ;;
        *)
            fail "stato Repository preparation non ammesso: '${preparation_state:-<assente>}'"
            ;;
    esac
fi

check_section_state \
    docs/progress/README.md \
    "## Learner activity" \
    "not studied"

check_section_state \
    docs/progress/README.md \
    "## Implementation" \
    "not started"

check_section_state \
    docs/progress/README.md \
    "## Verification" \
    "not applicable"

printf '\n===== SOURCE COVERAGE =====\n'

if grep -Fx 'Stato del documento: prepared / structural only' \
    docs/source-coverage/README.md >/dev/null 2>&1; then
    ok "source coverage marcata structural only"
else
    fail "marker structural-only assente dalla source coverage"
fi

if grep -Fx 'Stato learner: not studied' \
    docs/source-coverage/README.md >/dev/null 2>&1; then
    ok "source coverage mantiene learner not studied"
else
    fail "source coverage non mantiene learner not studied"
fi

if grep -Fx 'Studio delle lezioni: not started' \
    docs/source-coverage/README.md >/dev/null 2>&1; then
    ok "studio della fonte dichiarato not started"
else
    fail "stato studio fonte assente o incoerente"
fi

if grep -Fx 'Implementazione derivata dalla fonte: none' \
    docs/source-coverage/README.md >/dev/null 2>&1; then
    ok "nessuna implementazione derivata dichiarata"
else
    fail "stato implementazione derivata assente o incoerente"
fi

printf '\n===== STUDY MAP =====\n'

if grep -Fx 'Stato del documento: draft / prepared' \
    docs/study-map/README.md >/dev/null 2>&1; then
    ok "study map marcata draft / prepared"
else
    fail "marker draft / prepared assente dalla study map"
fi

if grep -Fx 'Stato learner: not studied' \
    docs/study-map/README.md >/dev/null 2>&1; then
    ok "study map mantiene learner not studied"
else
    fail "study map non mantiene learner not studied"
fi

if grep -Fx 'Stato implementation: not started' \
    docs/study-map/README.md >/dev/null 2>&1; then
    ok "study map mantiene implementation not started"
else
    fail "study map non mantiene implementation not started"
fi

if grep -Fx 'Stato verification: not applicable' \
    docs/study-map/README.md >/dev/null 2>&1; then
    ok "study map mantiene verification not applicable"
else
    fail "study map non mantiene verification not applicable"
fi

printf '\n===== AREE DIDATTICHE ANCORA VUOTE =====\n'

check_only_readme theory
check_only_readme exercises
check_only_readme implementations
check_only_readme lesson-learned

printf '\n===== CONFINE PRIVATO =====\n'

if grep -Fx 'sources/private/' .gitignore >/dev/null 2>&1; then
    ok "sources/private/ dichiarato in .gitignore"
else
    fail "sources/private/ assente da .gitignore"
fi

if git check-ignore -q sources/private/example.txt 2>/dev/null; then
    ok "Git ignora realmente sources/private/"
else
    fail "Git non ignora realmente sources/private/"
fi

tracked_private="$(
    git ls-files \
        | grep -E '(^|/)(sources/private|private|personal)(/|$)' \
        || true
)"

if [ -z "$tracked_private" ]; then
    ok "nessun materiale privato tracciato"
else
    printf '%s\n' "$tracked_private"
    fail "materiale privato già presente nell'indice Git"
fi

printf '\n===== CONTENUTO PUBBLICO / ANTI-LEAKAGE =====\n'

forbidden_found=0

while IFS= read -r -d '' path; do
    lower="${path,,}"

    case "$lower" in
        sources/private/*|*/sources/private/*|\
        private/*|*/private/*|\
        personal/*|*/personal/*)
            printf 'ERRORE: percorso privato candidabile al repository: %s\n' "$path"
            forbidden_found=1
            ;;
    esac

    case "$lower" in
        .env|.env.*|*/.env|*/.env.*|\
        *.pem|*.key|\
        id_rsa|*/id_rsa|\
        id_ed25519|*/id_ed25519)
            printf 'ERRORE: possibile segreto/credenziale: %s\n' "$path"
            forbidden_found=1
            ;;
    esac

    case "$lower" in
        *.pdf|*.epub|*.mobi|*.azw|*.azw3)
            printf 'ERRORE: documento sorgente/binario non ammesso: %s\n' "$path"
            forbidden_found=1
            ;;
    esac

    case "$lower" in
        sources/*.mp3|sources/*.wav|sources/*.flac|sources/*.m4a|\
        sources/*.mp4|sources/*.mkv|sources/*.avi|sources/*.mov|\
        sources/*.png|sources/*.jpg|sources/*.jpeg|sources/*.gif|sources/*.webp|\
        sources/*/*.mp3|sources/*/*.wav|sources/*/*.flac|sources/*/*.m4a|\
        sources/*/*.mp4|sources/*/*.mkv|sources/*/*.avi|sources/*/*.mov|\
        sources/*/*.png|sources/*/*.jpg|sources/*/*.jpeg|sources/*/*.gif|sources/*/*.webp)
            printf 'ERRORE: materiale sorgente binario sotto sources/: %s\n' "$path"
            forbidden_found=1
            ;;
    esac

    case "$lower" in
        transcript/*|transcripts/*|*/transcript/*|*/transcripts/*)
            printf 'ERRORE: transcript pubblico rilevato: %s\n' "$path"
            forbidden_found=1
            ;;
    esac
done < <(
    git ls-files -z --cached --others --exclude-standard
)

if [ "$forbidden_found" -eq 0 ]; then
    ok "nessun candidato pubblico vietato rilevato"
else
    fail "anti-leakage content check"
fi

printf '\n===== LINK MARKDOWN RELATIVI =====\n'

if python3 scripts/check-markdown-links.py; then
    ok "validazione link Markdown"
else
    fail "validazione link Markdown"
fi

printf '\n===== INTEGRAZIONE CI =====\n'

check_file .github/workflows/ci.yml

if [ -x scripts/check-repository.sh ]; then
    ok "validator locale eseguibile"
else
    fail "scripts/check-repository.sh non è eseguibile"
fi

if [ -f .github/workflows/ci.yml ]; then
    if grep -Fx '  contents: read' \
        .github/workflows/ci.yml >/dev/null 2>&1; then
        ok "CI limita GITHUB_TOKEN a contents: read"
    else
        fail "CI senza permissions contents: read esplicito"
    fi

    if grep -Eq '^[[:space:]]*pull_request_target:' \
        .github/workflows/ci.yml; then
        fail "pull_request_target non ammesso nel workflow di validazione"
    else
        ok "CI non usa pull_request_target"
    fi

    if grep -Fx '          persist-credentials: false' \
        .github/workflows/ci.yml >/dev/null 2>&1; then
        ok "checkout non persiste credenziali"
    else
        fail "persist-credentials: false assente dal checkout"
    fi

    checkout_ref="$(
        sed -n \
            's/^[[:space:]]*uses:[[:space:]]*actions\/checkout@\([0-9a-fA-F]*\).*$/\1/p' \
            .github/workflows/ci.yml \
            | head -n 1
    )"

    case "$checkout_ref" in
        [0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]*)
            if [ "${#checkout_ref}" -eq 40 ]; then
                ok "actions/checkout usa un riferimento SHA a 40 caratteri"
            else
                fail "actions/checkout non usa uno SHA completo a 40 caratteri"
            fi
            ;;
        *)
            fail "actions/checkout non risulta SHA-pinned"
            ;;
    esac

    if grep -Fx \
        '        run: scripts/check-repository.sh --require-prepared' \
        .github/workflows/ci.yml >/dev/null 2>&1; then
        ok "CI invoca il validator canonico con --require-prepared"
    else
        fail "CI non invoca esattamente il gate canonico --require-prepared"
    fi

    if grep -E -n \
        'curl|wget|pip install|npm install|pnpm install|yarn install|apt(-get)? install|bash <|sh <' \
        .github/workflows/ci.yml >/dev/null 2>&1; then
        fail "workflow contiene installer o download remoto non ammesso"
    else
        ok "workflow senza installer/download remoto"
    fi
fi

printf '\n===== HYGIENE GIT =====\n'

if git diff --check; then
    ok "git diff --check"
else
    fail "git diff --check"
fi

if git diff --cached --check; then
    ok "git diff --cached --check"
else
    fail "git diff --cached --check"
fi

printf '\n===== RISULTATO =====\n'

if [ "$failures" -eq 0 ]; then
    printf '%s\n' "OK: repository validation passed."
    exit 0
fi

printf 'ERRORE: repository validation failed con %s problema/i.\n' "$failures"
exit 1
