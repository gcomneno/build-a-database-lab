#!/usr/bin/env python3

from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parent.parent

LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")


def candidate_markdown_files() -> list[Path]:
    result = subprocess.run(
        [
            "git",
            "ls-files",
            "--cached",
            "--others",
            "--exclude-standard",
            "*.md",
        ],
        cwd=ROOT,
        check=True,
        capture_output=True,
        text=True,
    )

    return [
        ROOT / line
        for line in result.stdout.splitlines()
        if line.strip()
    ]


def extract_target(raw: str) -> str:
    value = raw.strip()

    if value.startswith("<"):
        closing = value.find(">")
        if closing != -1:
            return value[1:closing]

    return value.split(maxsplit=1)[0] if value else ""


def is_external_or_anchor(target: str) -> bool:
    if not target:
        return True

    if target.startswith("#") or target.startswith("//"):
        return True

    parsed = urlsplit(target)

    return bool(parsed.scheme or parsed.netloc)


def validate_link(source: Path, target: str) -> str | None:
    if is_external_or_anchor(target):
        return None

    parsed = urlsplit(target)
    relative_path = unquote(parsed.path)

    if not relative_path:
        return None

    if relative_path.startswith("/"):
        return None

    resolved = (source.parent / relative_path).resolve()

    try:
        resolved.relative_to(ROOT)
    except ValueError:
        return f"link esce dal repository: {target}"

    if not resolved.exists():
        return f"destinazione inesistente: {target}"

    return None


def main() -> int:
    failures: list[str] = []

    for markdown_file in candidate_markdown_files():
        text = markdown_file.read_text(encoding="utf-8")

        for match in LINK_RE.finditer(text):
            target = extract_target(match.group(1))
            error = validate_link(markdown_file, target)

            if error is not None:
                relative_source = markdown_file.relative_to(ROOT)
                line = text.count("\n", 0, match.start()) + 1
                failures.append(
                    f"{relative_source}:{line}: {error}"
                )

    if failures:
        for failure in failures:
            print(f"ERRORE: {failure}")

        print(
            f"ERRORE: validazione link Markdown fallita "
            f"con {len(failures)} problema/i."
        )
        return 1

    print("OK: link Markdown relativi validi.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
