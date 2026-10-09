#!/usr/bin/env python3
"""Arayüz eklemeleri: seviye seçme ekranı + logonun altındaki "MPC EDITION" yazısı (SWF v5 uyumlu).

SWF v5'te çizim API'si / createEmptyMovieClip / onRelease yok, bu yüzden ekran
çalışma anında çizilemiyor. Bunun yerine bu betik gerçek Flash nesneleri üretir:
şekiller (DefineShape3), yazılar (DefineEditText), butonlar (DefineButton2) ve
hepsini içeren bir sprite. Sprite "izbornik" adıyla dışa aktarılır, böylece
ActionScript'ten _root.attachMovie("izbornik", ...) ile açılabilir.

Butonlar sadece izbor(N) fonksiyonunu çağırır (geri butonu: izbor(0));
asıl mantık src/scripts/frame_1/DoAction.as içindedir.

"MPC EDITION" rozeti, ana menüdeki "BUBBLE TROUBLE" logosunun sprite'ına (433)
çocuk olarak eklenir; böylece logo nerede/ne zaman görünüyorsa o da görünür.

Kullanım: inject_ui.py <girdi.swf> <çıktı.swf>
"""
import struct
import sys

LEVEL_COUNT = 17
FIRST_ID = 800  # orijinal dosyada en büyük karakter ID'si 702
SCYTHE_SRC = 589  # "Scythe": oyunun seviye numarası fontu (0-9 rakamları gömülü)
VERDANA_SRC = 699  # "Verdana": glifsiz, sistem fontu olarak çizilir
# Orijinal fontlar ancak 254. ve 428. karelerde tanımlanıyor; menü 194. karede.
# Bu yüzden kendi kopyalarımızı en başta tanımlıyoruz.
FONT_NUMBERS = FIRST_ID + 900  # Scythe'ın kopyası
FONT_DEVICE = FIRST_ID + 901  # Verdana'nın kopyası
FONT_DEVICE_BOLD = FIRST_ID + 902  # Verdana kopyası, kalın
LOGO_SPRITE = 433  # ana menüdeki "BUBBLE TROUBLE" logosu
LOGO_X, LOGO_Y, LOGO_SCALE = 167.8, 99.7, 0.95  # logonun ana menüdeki yeri (194. kare)
TW = 20  # 1 piksel = 20 twip

# Renkler (RGBA) — ana menüdeki kırmızı butonlar / altın çerçeve / sarı yazı
DIM = (0, 0, 0, 150)
PANEL_FILL = (140, 38, 18, 245)
GOLD = (230, 184, 74, 255)
BTN_FILL = (205, 64, 40, 255)
BTN_HOVER = (240, 110, 60, 255)
BTN_DOWN = (170, 40, 24, 255)
YELLOW = (255, 231, 0, 255)


class BitWriter:
    def __init__(self):
        self.out = bytearray()
        self.cur = 0
        self.n = 0

    def ub(self, nbits, v):
        for i in range(nbits - 1, -1, -1):
            self.cur = (self.cur << 1) | ((v >> i) & 1)
            self.n += 1
            if self.n == 8:
                self.out.append(self.cur)
                self.cur = self.n = 0

    def sb(self, nbits, v):
        self.ub(nbits, v & ((1 << nbits) - 1))

    def bytes(self):
        if self.n:
            self.out.append(self.cur << (8 - self.n))
            self.cur = self.n = 0
        return bytes(self.out)


def sbits(*vals):
    """İşaretli değerler için gereken bit sayısı."""
    n = 1
    for v in vals:
        need = (v.bit_length() if v >= 0 else (-v - 1).bit_length()) + 1
        n = max(n, need)
    return n


def rect(x0, x1, y0, y1):
    w = BitWriter()
    nb = sbits(x0, x1, y0, y1)
    w.ub(5, nb)
    for v in (x0, x1, y0, y1):
        w.sb(nb, v)
    return w.bytes()


def matrix(tx, ty):
    w = BitWriter()
    w.ub(1, 0)  # HasScale
    w.ub(1, 0)  # HasRotate
    nb = sbits(tx, ty) if (tx or ty) else 0
    w.ub(5, nb)
    if nb:
        w.sb(nb, tx)
        w.sb(nb, ty)
    return w.bytes()


def cxform_identity():
    w = BitWriter()
    w.ub(1, 0)  # HasAddTerms
    w.ub(1, 0)  # HasMultTerms
    w.ub(4, 0)
    return w.bytes()


def tag(code, body):
    if len(body) < 63:
        return struct.pack('<H', (code << 6) | len(body)) + body
    return struct.pack('<HI', (code << 6) | 63, len(body)) + body


def rgba(c):
    return bytes(c)


def string(s):
    return s.encode('latin-1') + b'\0'


def rounded_rect_shape(cid, w_px, h_px, fill, line=None, line_px=0, radius_px=0):
    """(0,0)-(w,h) piksel dikdörtgen, isteğe bağlı yuvarlak köşe ve çerçeve."""
    W, H, r = w_px * TW, h_px * TW, radius_px * TW
    lw = line_px * TW
    pad = lw // 2 + TW
    body = struct.pack('<H', cid) + rect(-pad, W + pad, -pad, H + pad)
    body += bytes([1, 0x00]) + rgba(fill)  # 1 düz dolgu
    if line:
        body += bytes([1]) + struct.pack('<H', lw) + rgba(line)
    else:
        body += bytes([0])
    bw = BitWriter()
    bw.ub(4, 1)  # NumFillBits
    bw.ub(4, 1 if line else 0)  # NumLineBits
    # StyleChangeRecord: moveTo (r, 0), fill0=1, line=1
    bw.ub(1, 0)
    bw.ub(1, 0)  # NewStyles
    bw.ub(1, 1 if line else 0)  # LineStyle
    bw.ub(1, 0)  # FillStyle1
    bw.ub(1, 1)  # FillStyle0
    bw.ub(1, 1)  # MoveTo
    nb = sbits(r, 0)
    bw.ub(5, nb)
    bw.sb(nb, r)
    bw.sb(nb, 0)
    bw.ub(1, 1)  # fill0
    if line:
        bw.ub(1, 1)

    def straight(dx, dy):
        nb = max(sbits(dx, dy), 2)
        bw.ub(1, 1)
        bw.ub(1, 1)
        bw.ub(4, nb - 2)
        bw.ub(1, 1)  # GeneralLine
        bw.sb(nb, dx)
        bw.sb(nb, dy)

    def curve(cx, cy, ax, ay):
        nb = max(sbits(cx, cy, ax, ay), 2)
        bw.ub(1, 1)
        bw.ub(1, 0)
        bw.ub(4, nb - 2)
        for v in (cx, cy, ax, ay):
            bw.sb(nb, v)

    straight(W - 2 * r, 0)
    if r:
        curve(r, 0, 0, r)
    straight(0, H - 2 * r)
    if r:
        curve(0, r, -r, 0)
    straight(-(W - 2 * r), 0)
    if r:
        curve(-r, 0, 0, -r)
    straight(0, -(H - 2 * r))
    if r:
        curve(0, -r, r, 0)
    bw.ub(6, 0)  # EndShapeRecord
    return tag(32, body + bw.bytes())


def edit_text(cid, w_px, h_px, text, font, size_px, color, outlines, align=2, margin_px=0):
    body = struct.pack('<H', cid) + rect(0, w_px * TW, 0, h_px * TW)
    flags1 = 0x80 | 0x08 | 0x04 | 0x01  # HasText, ReadOnly, HasTextColor, HasFont
    flags2 = 0x20 | 0x10 | (0x01 if outlines else 0)  # HasLayout, NoSelect, UseOutlines
    body += bytes([flags1, flags2])
    body += struct.pack('<HH', font, size_px * TW) + rgba(color)
    body += bytes([align]) + struct.pack('<HHHh', margin_px * TW, 0, 0, 0)  # 0 sol, 2 orta
    body += string('') + string(text)
    return tag(37, body)


def push(*items):
    data = bytearray()
    for it in items:
        if isinstance(it, str):
            data += b'\x00' + string(it)
        else:
            data += b'\x07' + struct.pack('<i', it)
    return b'\x96' + struct.pack('<H', len(data)) + bytes(data)


def call(fn, *args):
    """fn(args...) çağrısı, dönüş değeri atılır."""
    return push(*reversed(args), len(args), fn) + b'\x3d' + b'\x17'


def button(cid, up, over, down, label, label_x, label_y, on_release):
    recs = bytearray()

    def rec(states, char, depth, x=0, y=0):
        return bytes([states]) + struct.pack('<HH', char, depth) + matrix(x * TW, y * TW) + cxform_identity()

    recs += rec(0x01 | 0x08, up, 1)  # up + hit
    recs += rec(0x02, over, 2)
    recs += rec(0x04, down, 3)
    recs += rec(0x01 | 0x02 | 0x04, label, 4, label_x, label_y)
    recs += b'\x00'
    roll_over = call('ozvuci', 'puni1') + b'\x00'
    release = on_release + b'\x00'
    conds = struct.pack('<H', 4 + len(roll_over)) + bytes([0x01, 0x00]) + roll_over  # on(rollOver)
    conds += struct.pack('<H', 0) + bytes([0x08, 0x00]) + release  # on(release)
    body = struct.pack('<HB', cid, 0) + struct.pack('<H', 2 + len(recs)) + recs + conds
    return tag(34, body)


def place(depth, char, x, y, name=None):
    flags = 0x06 | (0x20 if name else 0)
    body = bytes([flags]) + struct.pack('<HH', depth, char) + matrix(x * TW, y * TW)
    if name:
        body += string(name)
    return tag(26, body)


def iter_tags(d):
    p = 0
    while p < len(d):
        h = struct.unpack('<H', d[p:p + 2])[0]
        p += 2
        t, l = h >> 6, h & 63
        if l == 63:
            l = struct.unpack('<I', d[p:p + 4])[0]
            p += 4
        yield t, d[p:p + l]
        p += l
        if t == 0:
            return


def font_tags(tags):
    def copy(src_id, new_id, extra_flags=0):
        body = next(b for t, b in tags if t == 48 and struct.unpack('<H', b[:2])[0] == src_id)
        return tag(48, struct.pack('<HB', new_id, body[2] | extra_flags) + body[3:])
    return (copy(SCYTHE_SRC, FONT_NUMBERS) + copy(VERDANA_SRC, FONT_DEVICE)
            + copy(VERDANA_SRC, FONT_DEVICE_BOLD, 0x01))


def build_badge(ids):
    """ "MPC EDITION" rozeti: menü butonları gibi kırmızı zemin, altın çerçeve, sarı yazı."""
    out = bytearray()
    w, h = 190, 28
    shape, lbl, spr = next(ids), next(ids), next(ids)
    out += rounded_rect_shape(shape, w, h, BTN_FILL, GOLD, 3, 10)
    out += edit_text(lbl, w, 26, 'MPC EDITION', FONT_DEVICE_BOLD, 19, YELLOW, False)
    body = place(1, shape, 0, 0) + place(2, lbl, 0, 1) + tag(1, b'') + tag(0, b'')
    out += tag(39, struct.pack('<HH', spr, 1) + body)
    return bytes(out), spr, w


OZELLIKLER = [  # (tuş, yazı) - sıra src/scripts/frame_1/DoAction.as'teki _root.ozelliksilah ile aynı
    ('1', 'SPIKED SHOT'),
    ('2', 'LASER'),
    ('3', 'MINE'),
    ('4', 'NORMAL SHOT'),
]
WIN_FILL = (40, 10, 4, 150)  # yarı saydam koyu zemin
HILITE = (230, 184, 74, 110)  # seçili satır vurgusu


def build_window(ids):
    """Oyun sırasında 1-4 tuşlarıyla açılan yarı saydam özel atış penceresi ("ozellikler").

    Seçili satırın vurgusu "secim" adlı örnek; ActionScript onu satırın y'sine taşır
    (44 + satır * 30 — buradaki top/row_h ile aynı olmalı).
    """
    out = bytearray()
    w, row_h, top = 250, 30, 44
    h = top + row_h * len(OZELLIKLER) + 12
    panel, hl, title, spr = next(ids), next(ids), next(ids), next(ids)
    out += rounded_rect_shape(panel, w, h, WIN_FILL, GOLD, 2, 10)
    out += rounded_rect_shape(hl, w - 16, row_h - 2, HILITE, None, 0, 6)
    out += edit_text(title, w, 30, 'SPECIAL SHOTS', FONT_DEVICE_BOLD, 20, YELLOW, False)
    body = place(1, panel, 0, 0) + place(2, title, 0, 8)
    # Adla erişilebilmesi için vurgu şekli bir sprite içinde (çıplak şekillere adla ulaşılamaz)
    hl_spr = next(ids)
    out += tag(39, struct.pack('<HH', hl_spr, 1) + place(1, hl, 0, 0) + tag(1, b'') + tag(0, b''))
    body += place(3, hl_spr, 8, top, 'secim')
    for i, (key, label) in enumerate(OZELLIKLER):
        y = top + i * row_h
        lbl = next(ids)
        out += edit_text(lbl, w - 16, row_h, key + '   ' + label, FONT_DEVICE, 18, YELLOW, False, align=0, margin_px=12)
        body += place(10 + i, lbl, 8, y + 2)
    body += tag(1, b'') + tag(0, b'')
    out += tag(39, struct.pack('<HH', spr, 1) + body)
    out += tag(56, struct.pack('<HH', 1, spr) + string('ozellikler'))
    return bytes(out)


def add_to_logo(sprite_body, badge, badge_w):
    """Logo sprite'ının ilk karesine rozeti ekler (logonun yazısının hemen altına, ortalı)."""
    # Ekranda: "TROUBLE" yazısının ortası x~185, altı y~160; menü çerçevesi y~188'de başlar.
    # Rozet bu boşluğa yerleşir. Logo koordinatlarına çevir.
    sx = (185 - badge_w * LOGO_SCALE / 2 - LOGO_X) / LOGO_SCALE
    sy = (160 - LOGO_Y) / LOGO_SCALE
    out = bytearray(sprite_body[:4])
    added = False
    for t, b in iter_tags(sprite_body[4:]):
        if t == 1 and not added:
            out += place(50, badge, round(sx), round(sy))
            added = True
        out += tag(t, b)
    return bytes(out)


def build_tags(tags, ids):
    out = bytearray(font_tags(tags))
    sprite = bytearray()

    # Arka plan karartma + panel
    bg, panel = next(ids), next(ids)
    out += rounded_rect_shape(bg, 700, 450, DIM)
    px, py, pw, ph = 100, 40, 500, 370
    out += rounded_rect_shape(panel, pw, ph, PANEL_FILL, GOLD, 4, 14)
    sprite += place(1, bg, 0, 0)
    sprite += place(2, panel, px, py)

    title = next(ids)
    out += edit_text(title, pw, 44, 'SELECT LEVEL', FONT_DEVICE, 30, YELLOW, False)
    sprite += place(3, title, px, py + 16)

    # Seviye butonları
    bw_, bh_, gap, cols = 64, 52, 12, 6
    shapes = []
    for fill in (BTN_FILL, BTN_HOVER, BTN_DOWN):
        sid = next(ids)
        out += rounded_rect_shape(sid, bw_, bh_, fill, GOLD, 3, 8)
        shapes.append(sid)
    grid_w = cols * bw_ + (cols - 1) * gap
    x0 = 350 - grid_w // 2
    y0 = py + 78
    depth = 10
    for n in range(1, LEVEL_COUNT + 1):
        lbl, btn = next(ids), next(ids)
        out += edit_text(lbl, bw_, 40, str(n), FONT_NUMBERS, 30, YELLOW, True)
        out += button(btn, *shapes, lbl, 0, 7, call('izbor', n))
        col, row = (n - 1) % cols, (n - 1) // cols
        sprite += place(depth, btn, x0 + col * (bw_ + gap), y0 + row * (bh_ + gap))
        depth += 1

    # Geri butonu
    back_w, back_h = 160, 46
    back_shapes = []
    for fill in (BTN_FILL, BTN_HOVER, BTN_DOWN):
        sid = next(ids)
        out += rounded_rect_shape(sid, back_w, back_h, fill, GOLD, 3, 10)
        back_shapes.append(sid)
    lbl, btn = next(ids), next(ids)
    out += edit_text(lbl, back_w, 34, 'BACK', FONT_DEVICE, 24, YELLOW, False)
    out += button(btn, *back_shapes, lbl, 0, 8, call('izbor', 0))
    sprite += place(depth, btn, 350 - back_w // 2, py + ph - back_h - 22)

    spr = next(ids)
    sprite += tag(1, b'') + tag(0, b'')
    out += tag(39, struct.pack('<HH', spr, 1) + bytes(sprite))
    out += tag(56, struct.pack('<HH', 1, spr) + string('izbornik'))
    return bytes(out)


def main(src, dst):
    d = open(src, 'rb').read()
    if d[:3] != b'FWS':
        sys.exit('beklenen: sıkıştırılmamış SWF (FWS)')
    body = d[8:]
    nb = body[0] >> 3
    hdr_len = (5 + 4 * nb + 7) // 8 + 4
    # Yeni tanımlar en başa (1. kareden önce) eklenir, böylece her yerden kullanılabilir.
    tags = list(iter_tags(body[hdr_len:]))
    ids = iter(range(FIRST_ID, FIRST_ID + 100))
    defs = build_tags(tags, ids)
    badge_tags, badge, badge_w = build_badge(ids)
    badge_tags += build_window(ids)
    rest = bytearray()
    for t, b in tags:
        if t == 39 and struct.unpack('<H', b[:2])[0] == LOGO_SPRITE:
            b = add_to_logo(b, badge, badge_w)
        rest += tag(t, b)
    new = body[:hdr_len] + defs + badge_tags + bytes(rest)
    open(dst, 'wb').write(d[:4] + struct.pack('<I', len(new) + 8) + new)


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
