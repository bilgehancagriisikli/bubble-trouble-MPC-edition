#!/usr/bin/env bash
# JPEXS FFDec (SWF decompiler/derleyici) indirir -> tools/ffdec/
set -euo pipefail
cd "$(dirname "$0")"
VER=24.0.1
[ -f ffdec/ffdec.jar ] && { echo "ffdec zaten kurulu"; exit 0; }
curl -sSL -o ffdec.zip "https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version${VER}/ffdec_${VER}.zip"
mkdir -p ffdec && unzip -q -o ffdec.zip -d ffdec && rm ffdec.zip
echo "ffdec $VER kuruldu"
