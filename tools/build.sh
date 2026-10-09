#!/usr/bin/env bash
# src/ altındaki scriptleri orijinal SWF'e geri derler -> build/bubble_trouble_mpc.swf
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/tools/setup.sh" >/dev/null
mkdir -p "$ROOT/build"
java -Djava.awt.headless=true -jar "$ROOT/tools/ffdec/ffdec.jar" \
  -importScript "$ROOT/original/bubble_trouble.swf" "$ROOT/build/bubble_trouble_mpc.swf" "$ROOT/src" 2>&1 | grep -v JAVA_TOOL_OPTIONS
echo "-> build/bubble_trouble_mpc.swf"
