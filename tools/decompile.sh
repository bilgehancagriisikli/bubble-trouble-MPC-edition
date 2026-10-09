#!/usr/bin/env bash
# Orijinal SWF'den scriptleri src/ altına yeniden çıkarır (src/ üzerine yazar!)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/tools/setup.sh" >/dev/null
rm -rf "$ROOT/src/scripts"
java -Djava.awt.headless=true -jar "$ROOT/tools/ffdec/ffdec.jar" -export script "$ROOT/src" "$ROOT/original/bubble_trouble.swf" 2>&1 | tail -1
