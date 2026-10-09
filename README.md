# Bubble Trouble — MPC Edition

Flash oyunu *Bubble Trouble* (SWF v5, ActionScript 1) üzerine mod çalışması.

## Yapı
- `original/bubble_trouble.swf` — dokunulmamış orijinal oyun
- `src/scripts/` — JPEXS FFDec ile çıkarılmış ActionScript kodları (modlar burada yapılır)
- `tools/build.sh` — `src/` içindeki scriptleri orijinal SWF'e gömüp `build/bubble_trouble_mpc.swf` üretir
- `tools/decompile.sh` — scriptleri orijinalden yeniden çıkarır
- `tools/setup.sh` — FFDec'i indirir (Java gerekir)

## Önemli dosyalar
- `src/scripts/frame_1/DoAction.as` — tuş atamaları, ses, ortak fonksiyonlar
- `src/scripts/frame_254/DoAction_2.as` — oyun ayarları (can, hız, yerçekimi, silahlar, top boyutları)
- `src/scripts/frame_254/DoAction_3..6.as` — oyun mantığı (seviyeler, süre, kapılar, ölüm)

Değişken isimleri Hırvatça: `lives` = can, `brzinaigraca` = oyuncu hızı, `gravitacija` = yerçekimi,
`pucanjvrsta` = silah türleri, `vrijemestaze` = bölüm süresi, `loptica` = top, `razina` = seviye.

## Derleme
```bash
./tools/build.sh
```
Çıkan SWF'i Ruffle (https://ruffle.rs) veya Flash Player projector ile oynayabilirsin.
