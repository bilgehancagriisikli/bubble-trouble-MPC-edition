# Bubble Trouble — MPC Edition

Flash oyunu *Bubble Trouble* (SWF v5, ActionScript 1) üzerine mod çalışması.

## Yapı
- `original/bubble_trouble.swf` — dokunulmamış orijinal oyun
- `src/scripts/` — JPEXS FFDec ile çıkarılmış ActionScript kodları (modlar burada yapılır)
- `tools/build.sh` — seviye seçme ekranını ekler, `src/` içindeki scriptleri orijinal SWF'e gömüp `build/bubble_trouble_mpc.swf` üretir
- `tools/inject_ui.py` — seviye seçme ekranını, "MPC EDITION" yazısını ve özel atış penceresini SWF'e yeni karakterler olarak ekler
- `tools/decompile.sh` — scriptleri orijinalden yeniden çıkarır
- `tools/setup.sh` — FFDec'i indirir (Java gerekir)

## Önemli dosyalar
- `src/scripts/frame_1/DoAction.as` — tuş atamaları, ses, ortak fonksiyonlar
- `src/scripts/frame_254/DoAction_2.as` — oyun ayarları (can, hız, yerçekimi, silahlar, top boyutları)
- `src/scripts/frame_254/DoAction_3..6.as` — oyun mantığı (seviyeler, süre, kapılar, ölüm)

Değişken isimleri Hırvatça: `lives` = can, `brzinaigraca` = oyuncu hızı, `gravitacija` = yerçekimi,
`pucanjvrsta` = silah türleri, `vrijemestaze` = bölüm süresi, `loptica` = top, `razina` = seviye.

## Modlar
- **MPC bölümü** — seviye seçme ekranında 17'nin yanındaki **MPC** butonu. 17. bölümün sahnesinde, her saniye
  sırayla bir sağdan bir soldan oyunun en büyük topu gelir, sonsuza dek (bölüm bitmez). HUD'da seviye yerine "MPC" yazar.
  Mantık: `src/scripts/frame_1/DoAction.as` (`razinaya_git`, `mpc_dongu`, `mpc_top`, `_root.mpclevel`);
  17. bölümün top üreticileri `frame_398` içinde MPC'de devre dışı. Buton/etiket: `tools/inject_ui.py`.
- **Ana menüde QUIT** — orijinalde tıklama eylemi yoktu (sadece şeytan sırıtıyordu). Artık `fscommand("quit")`
  gönderir: Ruffle masaüstü programı ve Flash Player projektörü kapanır; tarayıcıda sekme kapatılamaz.
  (`tools/inject_ui.py`, `QUIT_BUTTON`)
- **Özel atış penceresi** — oyun sırasında **1** normal atış, **2** dikenli atış (tavana yapışan kanca),
  **3** lazer, **4** mayın, **5** çift atış (yeni: iki normal zıpkın yan yana; oyunun orijinalinde yok). Tuşa basınca yarı saydam bir pencere açılır, seçili satır vurgulanır, ~2,5 sn sonra
  solarak kaybolur. Seçim iki oyuncuya da uygulanır ve bölümler/ölümler arasında kalır.
  Pencere: `tools/inject_ui.py` (`build_window`); mantık: `src/scripts/frame_1/DoAction.as` (`ozellik_tuslari`, `ozellik_sec`).
- **Sınırsız atış** — ekranda aynı anda istediğin kadar atış olabilir; ateş tuşu basılı tutulunca
  120 ms'de bir atış yapılır (`_root.atisaralik`). `initshot`/`yeniatis` (`frame_254/DoAction_4.as`),
  toplara çarpma `bauns` (`frame_254/DoAction_6.as`).
- **"MPC EDITION" yazısı** — ana menüde logonun altında (`tools/inject_ui.py`, logo sprite'ı 433'e eklenir).
- **Sonsuz can** — can hiç azalmaz (`// MOD: sonsuz can` satırları).
- **Sonsuz süre** — süre çubuğu hep dolu kalır (`staza_tece`, `frame_254/DoAction_3.as`).
- **Tavanı durdurma** — inen tavanlı bölümde (6. seviye) **S** tuşu tavanı durdurur / tekrar başlatır (`spustistrop`).
- **Zararsız tavan** — tavan oyuncuyu ezmez, oyuncunun başının üstünde durur; topları eskisi gibi patlatır.
- **Toplar oyuncunun içinden geçer** — top oyuncuya değince öldürmez, yoluna devam eder
  (`bauns`, `frame_254/DoAction_6.as`).
- **Seviye seçme ekranı** — 1 PLAYER / 2 PLAYERS'a basınca ve her bölüm bittiğinde 17 seviyeden biri seçilir.
  Bölüm sonunda BACK ana menüye döner.
  - Bölüm sonu: `src/scripts/DefineSprite_71_gotov` → `izborrazine_oyunda`
  - Ekran: `tools/inject_ui.py` ("izbornik" sprite'ı)
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
