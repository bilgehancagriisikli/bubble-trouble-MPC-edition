#!/usr/bin/env bash
# src/ altındaki scriptleri orijinal SWF'e geri derler -> build/bubble_trouble_mpc.swf
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/build/bubble_trouble_mpc.swf"
"$ROOT/tools/setup.sh" >/dev/null
mkdir -p "$ROOT/build"
# 1) Seviye seçme ekranını yeni karakterler olarak ekle
python3 "$ROOT/tools/inject_levelselect.py" "$ROOT/original/bubble_trouble.swf" "$ROOT/build/base.swf"
# 2) src/ altındaki (değiştirilmiş) scriptleri derleyip göm
java -Djava.awt.headless=true -jar "$ROOT/tools/ffdec/ffdec.jar" \
  -importScript "$ROOT/build/base.swf" "$OUT" "$ROOT/src" 2>&1 | grep -v -e JAVA_TOOL_OPTIONS -e "^Using the directory" || true
rm -f "$ROOT/build/base.swf"
echo "-> build/bubble_trouble_mpc.swf"
