#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
# run.sh – Simple driver for main.pl
#
# ▸ With no arguments:   opens an interactive SWI-Prolog REPL
# ▸ With a goal string:  runs that goal non-interactively
#
#   Examples
#     ./run.sh                          # REPL, KB pre-loaded
#     ./run.sh "grandparent(john,G)."   # quick query + exit
#
# Works on Linux, macOS, WSL, Git Bash (Windows) – anywhere
# SWI-Prolog (‘swipl’) is on the PATH.
# ──────────────────────────────────────────────────────────────
set -euo pipefail

KB=main.pl          # knowledge-base file

# sanity check – file present?
[[ -f $KB ]] || { echo "❌  $KB not found."; exit 1; }

# sanity check – interpreter present?
command -v swipl >/dev/null 2>&1 || {
  echo "❌  SWI-Prolog (‘swipl’) not found on PATH."; exit 1;
}

if [[ $# -eq 0 ]]; then
  # ── interactive mode ───────────────────────────────────────
  echo "▶  Launching SWI-Prolog with $KB loaded…"
  echo "   Type ?- queries followed by a period.  Ctrl-D or halt. to quit."
  echo "──────────────────────────────────────────────────────────"
  exec swipl -s "$KB"
else
  # ── one-off goal mode ──────────────────────────────────────
  GOAL="$*"
  swipl -q -s "$KB" -g "$GOAL" -t halt
fi
