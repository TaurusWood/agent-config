#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"

install_link() {
  local source="$1"
  local target="$2"
  local label="$3"

  if [[ ! -e "$source" ]]; then
    echo "Error: source not found: $source" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" ]]; then
    local current_target
    current_target="$(readlink "$target")"
    if [[ "$current_target" == "$source" ]]; then
      echo "Already installed: $label -> $source"
      return
    fi
    rm "$target"
  elif [[ -e "$target" ]]; then
    local backup
    backup="$target.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target" "$backup"
    echo "Backed up existing $label to: $backup"
  fi

  ln -s "$source" "$target"
  echo "Installed: $label -> $source"
}

install_link "$REPO_ROOT/AGENTS.md" "$CODEX_HOME_DIR/AGENTS.md" "AGENTS.md"
install_link "$REPO_ROOT/standards" "$CODEX_HOME_DIR/standards" "fallback engineering standards"
install_link "$REPO_ROOT/skills/development-flow" "$CODEX_HOME_DIR/skills/development-flow" "development-flow skill"
