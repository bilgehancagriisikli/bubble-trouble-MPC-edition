# Bubble Trouble — MPC Edition

Flash oyunu *Bubble Trouble* (SWF v5, ActionScript 1) üzerine mod çalışması.

## Yapı
- `original/bubble_trouble.swf` — dokunulmamış orijinal oyun
- `src/scripts/` — JPEXS FFDec ile çıkarılmış ActionScript kodları (modlar burada yapılır)
- `tools/build.sh` — seviye seçme ekranını ekler, `src/` içindeki scriptleri orijinal SWF'e gömüp `build/bubble_trouble_mpc.swf` üretir
- `tools/inject_levelselect.py` — seviye seçme ekranını (şekiller, butonlar, yazılar) SWF'e yeni karakterler olarak ekler
- `tools/decompile.sh` — scriptleri orijinalden yeniden çıkarır
- `tools/setup.sh` — FFDec'i indirir (Java gerekir)

## Önemli dosyalar
- `src/scripts/frame_1/DoAction.as` — tuş atamaları, ses, ortak fonksiyonlar
- `src/scripts/frame_254/DoAction_2.as` — oyun ayarları (can, hız, yerçekimi, silahlar, top boyutları)
- `src/scripts/frame_254/DoAction_3..6.as` — oyun mantığı (seviyeler, süre, kapılar, ölüm)

Değişken isimleri Hırvatça: `lives` = can, `brzinaigraca` = oyuncu hızı, `gravitacija` = yerçekimi,
`pucanjvrsta` = silah türleri, `vrijemestaze` = bölüm süresi, `loptica` = top, `razina` = seviye.

## Modlar
- **Sonsuz can** — can hiç azalmaz (`// MOD: sonsuz can` satırları).
- **Sonsuz süre** — süre çubuğu hep dolu kalır (`staza_tece`, `frame_254/DoAction_3.as`).
- **Tavanı durdurma** — inen tavanlı bölümde (6. seviye) **S** tuşu tavanı durdurur / tekrar başlatır (`spustistrop`).
- **Zararsız tavan** — tavan oyuncuyu ezmez, oyuncunun başının üstünde durur; topları eskisi gibi patlatır.
- **Toplar oyuncudan seker** — top oyuncuya değince öldürmez, duvardan seker gibi yön değiştirir
  (`bauns`, `frame_254/DoAction_6.as`).
- **Seviye seçme ekranı** — 1 PLAYER / 2 PLAYERS'a basınca 17 seviyeden biri seçilir.
  - Ekran: `tools/inject_levelselect.py` ("izbornik" sprite'ı)
  - Mantık: `src/scripts/frame_1/DoAction.as` (`izborrazine`, `izbor`)
  - Menü butonları: `src/scripts/DefineButton2_446`, `DefineButton2_448`
  - Seçilen seviyeye atlama: `src/scripts/frame_258/DoAction.as`

## Notlar
- Oyun SWF v5. Sürüm 6'ya çıkarmak oyunu bozar: v5'te fonksiyon içindeki değişkenler
  (`_X`, `kolkodas` vb.) fonksiyonu çağıran klibe aittir, v6'da tanımlandığı yere.
  Bu yüzden v6 API'leri (çizim, createEmptyMovieClip, onRelease) kullanılamaz;
  yeni görsel öğeler SWF'e etiket olarak eklenir.

## Derleme
```bash
./tools/build.sh
```
Çıkan SWF'i Ruffle (https://ruffle.rs) veya Flash Player projector ile oynayabilirsin.
