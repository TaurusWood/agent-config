#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$REPO_ROOT/AGENTS.md"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
TARGET="$CODEX_HOME_DIR/AGENTS.md"

if [[ ! -f "$SOURCE" ]]; then
  echo "Error: source file not found: $SOURCE" >&2
  exit 1
fi

mkdir -p "$CODEX_HOME_DIR"

if [[ -L "$TARGET" ]]; then
  CURRENT_TARGET="$(readlink "$TARGET")"
  if [[ "$CURRENT_TARGET" == "$SOURCE" ]]; then
    echo "Already installed: $TARGET -> $SOURCE"
    exit 0
  fi

  rm "$TARGET"
elif [[ -e "$TARGET" ]]; then
  BACKUP="$TARGET.backup.$(date +%Y%m%d%H%M%S)"
  mv "$TARGET" "$BACKUP"
  echo "Backed up existing AGENTS.md to: $BACKUP"
fi

ln -s "$SOURCE" "$TARGET"
echo "Installed: $TARGET -> $SOURCE"
