#!/usr/bin/env python3
"""
Google Play Store 등록용 이미지 생성 스크립트
- 앱 아이콘 (512x512)
- 그래픽 이미지 (1024x500)
- 스크린샷 목업 5장 (1080x1920)
"""
import struct
import zlib
import math
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

# ── 색상 팔레트 (앱 테마) ──
PRIMARY_DARK = (26, 10, 46)       # #1A0A2E
PRIMARY_PURPLE = (108, 52, 131)   # #6C3483
ACCENT_GOLD = (212, 175, 55)     # #D4AF37
ACCENT_LIGHT = (245, 230, 204)   # #F5E6CC
CARD_BACK = (45, 27, 78)         # #2D1B4E
SURFACE_DARK = (22, 8, 42)       # #16082A
WHITE = (255, 255, 255)
WHITE_70 = (179, 179, 179)
BLACK = (0, 0, 0)
DARK_PURPLE = (30, 15, 50)
DEEP_PURPLE = (60, 30, 90)


def blend(c1, c2, t):
    """두 색을 t 비율로 혼합 (0.0=c1, 1.0=c2)"""
    t = max(0.0, min(1.0, t))
    return (
        int(c1[0] * (1 - t) + c2[0] * t),
        int(c1[1] * (1 - t) + c2[1] * t),
        int(c1[2] * (1 - t) + c2[2] * t),
    )


def create_png(width, height, pixels, filename):
    """pixels: height x width의 (r,g,b) 리스트 → PNG 파일 저장"""
    def chunk(ctype, data):
        c = ctype + data
        crc = struct.pack('>I', zlib.crc32(c) & 0xFFFFFFFF)
        return struct.pack('>I', len(data)) + c + crc

    sig = b'\x89PNG\r\n\x1a\n'
    ihdr = chunk(b'IHDR', struct.pack('>IIBBBBB', width, height, 8, 2, 0, 0, 0))

    raw = bytearray()
    for y in range(height):
        raw.append(0)  # filter: None
        for x in range(width):
            r, g, b = pixels[y][x]
            raw += struct.pack('BBB', r, g, b)

    compressed = zlib.compress(bytes(raw), 9)
    idat = chunk(b'IDAT', compressed)
    iend = chunk(b'IEND', b'')

    with open(filename, 'wb') as f:
        f.write(sig + ihdr + idat + iend)
    print(f"  Created: {filename} ({width}x{height})")


def radial_gradient(cx, cy, x, y, radius):
    """원형 그라데이션 t 값 (0=중심, 1=가장자리)"""
    dist = math.sqrt((x - cx) ** 2 + (y - cy) ** 2)
    return min(dist / radius, 1.0)


def draw_circle(pixels, cx, cy, radius, color, width, height):
    """원 그리기"""
    for y in range(max(0, cy - radius - 2), min(height, cy + radius + 3)):
        for x in range(max(0, cx - radius - 2), min(width, cx + radius + 3)):
            dist = math.sqrt((x - cx) ** 2 + (y - cy) ** 2)
            if abs(dist - radius) < 1.5:
                t = 1.0 - abs(dist - radius) / 1.5
                pixels[y][x] = blend(pixels[y][x], color, t)


def draw_filled_circle(pixels, cx, cy, radius, color, width, height):
    """채워진 원 그리기"""
    for y in range(max(0, cy - radius - 1), min(height, cy + radius + 2)):
        for x in range(max(0, cx - radius - 1), min(width, cx + radius + 2)):
            dist = math.sqrt((x - cx) ** 2 + (y - cy) ** 2)
            if dist <= radius:
                pixels[y][x] = color
            elif dist < radius + 1:
                t = 1.0 - (dist - radius)
                pixels[y][x] = blend(pixels[y][x], color, t)


def draw_star(pixels, cx, cy, outer_r, inner_r, points, color, w, h):
    """별 모양 그리기"""
    star_points = []
    for i in range(points * 2):
        angle = math.pi * i / points - math.pi / 2
        r = outer_r if i % 2 == 0 else inner_r
        px = cx + r * math.cos(angle)
        py = cy + r * math.sin(angle)
        star_points.append((px, py))

    for y in range(max(0, cy - outer_r - 2), min(h, cy + outer_r + 3)):
        for x in range(max(0, cx - outer_r - 2), min(w, cx + outer_r + 3)):
            if point_in_polygon(x, y, star_points):
                pixels[y][x] = color


def point_in_polygon(x, y, polygon):
    """점이 다각형 안에 있는지 확인"""
    n = len(polygon)
    inside = False
    j = n - 1
    for i in range(n):
        xi, yi = polygon[i]
        xj, yj = polygon[j]
        if ((yi > y) != (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi):
            inside = not inside
        j = i
    return inside


def draw_rect(pixels, x1, y1, x2, y2, color, w, h):
    """채워진 사각형"""
    for y in range(max(0, y1), min(h, y2)):
        for x in range(max(0, x1), min(w, x2)):
            pixels[y][x] = color


def draw_rounded_rect(pixels, x1, y1, x2, y2, radius, color, w, h):
    """둥근 모서리 사각형"""
    for y in range(max(0, y1), min(h, y2)):
        for x in range(max(0, x1), min(w, x2)):
            # 모서리 확인
            in_rect = True
            corners = [
                (x1 + radius, y1 + radius),  # top-left
                (x2 - radius, y1 + radius),  # top-right
                (x1 + radius, y2 - radius),  # bottom-left
                (x2 - radius, y2 - radius),  # bottom-right
            ]
            if x < x1 + radius and y < y1 + radius:
                dist = math.sqrt((x - corners[0][0]) ** 2 + (y - corners[0][1]) ** 2)
                if dist > radius:
                    in_rect = False
            elif x > x2 - radius and y < y1 + radius:
                dist = math.sqrt((x - corners[1][0]) ** 2 + (y - corners[1][1]) ** 2)
                if dist > radius:
                    in_rect = False
            elif x < x1 + radius and y > y2 - radius:
                dist = math.sqrt((x - corners[2][0]) ** 2 + (y - corners[2][1]) ** 2)
                if dist > radius:
                    in_rect = False
            elif x > x2 - radius and y > y2 - radius:
                dist = math.sqrt((x - corners[3][0]) ** 2 + (y - corners[3][1]) ** 2)
                if dist > radius:
                    in_rect = False
            if in_rect:
                pixels[y][x] = color


def draw_gradient_rect(pixels, x1, y1, x2, y2, color1, color2, w, h):
    """그라데이션 사각형"""
    height = y2 - y1
    for y in range(max(0, y1), min(h, y2)):
        t = (y - y1) / max(height, 1)
        c = blend(color1, color2, t)
        for x in range(max(0, x1), min(w, x2)):
            pixels[y][x] = c


def draw_diamond(pixels, cx, cy, size, color, w, h):
    """다이아몬드(마름모) 그리기"""
    for y in range(max(0, cy - size), min(h, cy + size + 1)):
        for x in range(max(0, cx - size), min(w, cx + size + 1)):
            if abs(x - cx) + abs(y - cy) <= size:
                pixels[y][x] = color


# ═══════════════════════════════════════════
# 1. 앱 아이콘 (512x512)
# ═══════════════════════════════════════════
def generate_icon():
    print("Generating app icon (512x512)...")
    W, H = 512, 512
    pixels = [[BLACK for _ in range(W)] for _ in range(H)]

    # 배경: 원형 그라데이션
    for y in range(H):
        for x in range(W):
            t = radial_gradient(W // 2, H // 2, x, y, W * 0.7)
            pixels[y][x] = blend(PRIMARY_PURPLE, PRIMARY_DARK, t)

    # 외곽 원형 테두리
    draw_circle(pixels, 256, 256, 240, ACCENT_GOLD, W, H)
    draw_circle(pixels, 256, 256, 238, ACCENT_GOLD, W, H)

    # 내부 원
    draw_circle(pixels, 256, 256, 200, (80, 40, 110), W, H)

    # 중앙 큰 별 (5각)
    draw_star(pixels, 256, 240, 100, 40, 5, ACCENT_GOLD, W, H)

    # 별 중심에 작은 원
    draw_filled_circle(pixels, 256, 240, 25, PRIMARY_DARK, W, H)
    draw_circle(pixels, 256, 240, 25, ACCENT_GOLD, W, H)

    # 작은 다이아몬드 장식들
    for angle in range(0, 360, 45):
        rad = math.radians(angle)
        dx = int(256 + 170 * math.cos(rad))
        dy = int(256 + 170 * math.sin(rad))
        draw_diamond(pixels, dx, dy, 6, ACCENT_GOLD, W, H)

    # 하단 "TAROT" 텍스트 영역 (밑줄 장식)
    draw_rect(pixels, 160, 380, 352, 383, ACCENT_GOLD, W, H)
    draw_rect(pixels, 180, 390, 332, 393, (150, 120, 40), W, H)

    # 상단 작은 별 장식
    draw_star(pixels, 256, 80, 15, 6, 5, ACCENT_GOLD, W, H)
    draw_star(pixels, 180, 100, 8, 3, 5, (200, 160, 50), W, H)
    draw_star(pixels, 332, 100, 8, 3, 5, (200, 160, 50), W, H)

    path = os.path.join(SCRIPT_DIR, "icons", "app_icon_512x512.png")
    create_png(W, H, pixels, path)


# ═══════════════════════════════════════════
# 2. 그래픽 이미지 (1024x500)
# ═══════════════════════════════════════════
def generate_feature_graphic():
    print("Generating feature graphic (1024x500)...")
    W, H = 1024, 500
    pixels = [[BLACK for _ in range(W)] for _ in range(H)]

    # 배경 그라데이션
    for y in range(H):
        for x in range(W):
            t_y = y / H
            t_x = x / W
            bg = blend(PRIMARY_DARK, DEEP_PURPLE, t_y)
            # 중앙 밝은 포인트
            t_r = radial_gradient(W // 2, H // 2, x, y, W * 0.5)
            bg = blend(PRIMARY_PURPLE, bg, t_r)
            pixels[y][x] = bg

    # 좌측: 카드 모양
    card_x, card_y = 200, 80
    card_w, card_h = 200, 340
    # 카드 배경
    draw_rounded_rect(pixels, card_x, card_y, card_x + card_w, card_y + card_h,
                      16, CARD_BACK, W, H)
    # 카드 테두리
    for offset in range(2):
        for y in range(card_y, card_y + card_h):
            if 0 <= y < H:
                if card_x + offset < W:
                    pixels[y][card_x + offset] = ACCENT_GOLD
                if card_x + card_w - 1 - offset < W:
                    pixels[y][card_x + card_w - 1 - offset] = ACCENT_GOLD
        for x in range(card_x, card_x + card_w):
            if 0 <= x < W:
                if card_y + offset < H:
                    pixels[card_y + offset][x] = ACCENT_GOLD
                if card_y + card_h - 1 - offset < H:
                    pixels[card_y + card_h - 1 - offset][x] = ACCENT_GOLD

    # 카드 안의 별
    draw_star(pixels, card_x + card_w // 2, card_y + card_h // 2 - 20,
              60, 24, 5, ACCENT_GOLD, W, H)
    # 카드 안의 장식선
    draw_rect(pixels, card_x + 30, card_y + card_h - 60,
              card_x + card_w - 30, card_y + card_h - 57, ACCENT_GOLD, W, H)

    # 두 번째 카드 (살짝 겹침, 뒤에)
    card2_x = 160
    draw_rounded_rect(pixels, card2_x, card_y + 20, card2_x + card_w, card_y + 20 + card_h,
                      16, (35, 20, 60), W, H)

    # 우측: 텍스트 영역
    text_x = 480
    # "오늘의 타로" 텍스트 대체: 큰 별 + 장식
    draw_star(pixels, text_x + 50, 130, 30, 12, 5, ACCENT_GOLD, W, H)
    draw_star(pixels, text_x + 200, 100, 15, 6, 5, (200, 160, 50), W, H)
    draw_star(pixels, text_x + 350, 140, 20, 8, 5, (200, 160, 50), W, H)
    draw_star(pixels, text_x + 450, 110, 10, 4, 5, (180, 140, 40), W, H)

    # 장식 라인
    draw_rect(pixels, text_x, 190, text_x + 460, 193, ACCENT_GOLD, W, H)
    draw_rect(pixels, text_x + 40, 200, text_x + 420, 202, (150, 120, 40), W, H)

    # 카드 모양 미니 아이콘들
    for i in range(4):
        mx = text_x + 60 + i * 110
        my = 260
        draw_rounded_rect(pixels, mx, my, mx + 80, my + 120, 8, CARD_BACK, W, H)
        # 미니 카드 테두리
        for yy in range(my, my + 120):
            if 0 <= yy < H:
                pixels[yy][mx] = ACCENT_GOLD
                pixels[yy][mx + 79] = ACCENT_GOLD
        for xx in range(mx, mx + 80):
            if 0 <= xx < W:
                pixels[my][xx] = ACCENT_GOLD
                pixels[my + 119][xx] = ACCENT_GOLD
        # 미니 별
        draw_star(pixels, mx + 40, my + 50, 15, 6, 5, ACCENT_GOLD, W, H)

    # 하단 장식
    draw_rect(pixels, text_x, 420, text_x + 460, 423, (100, 70, 120), W, H)

    # 하단 작은 다이아몬드
    for i in range(8):
        dx = 100 + i * 120
        draw_diamond(pixels, dx, 470, 5, ACCENT_GOLD, W, H)

    path = os.path.join(SCRIPT_DIR, "graphics", "feature_graphic_1024x500.png")
    create_png(W, H, pixels, path)


# ═══════════════════════════════════════════
# 3. 스크린샷 목업 (1080x1920) x 5
# ═══════════════════════════════════════════
def generate_screenshot(index, title_text, elements, filename):
    """스크린샷 목업 생성"""
    W, H = 1080, 1920
    pixels = [[BLACK for _ in range(W)] for _ in range(H)]

    # 배경 그라데이션
    for y in range(H):
        for x in range(W):
            t = y / H
            pixels[y][x] = blend(PRIMARY_DARK, SURFACE_DARK, t)

    # 상단 헤더 영역
    draw_gradient_rect(pixels, 0, 0, W, 300, PRIMARY_PURPLE, PRIMARY_DARK, W, H)

    # 헤더 별 장식
    draw_star(pixels, W // 2, 120, 40, 16, 5, ACCENT_GOLD, W, H)
    draw_star(pixels, 200, 80, 12, 5, 5, (200, 160, 50), W, H)
    draw_star(pixels, 880, 80, 12, 5, 5, (200, 160, 50), W, H)

    # 헤더 하단 구분선
    draw_rect(pixels, 100, 240, W - 100, 243, ACCENT_GOLD, W, H)
    draw_rect(pixels, 150, 250, W - 150, 252, (150, 120, 40), W, H)

    # 컨텐츠 영역
    for elem in elements:
        elem_type = elem[0]
        if elem_type == 'card':
            cx, cy, cw, ch = elem[1], elem[2], elem[3], elem[4]
            draw_rounded_rect(pixels, cx, cy, cx + cw, cy + ch, 16, CARD_BACK, W, H)
            # 테두리
            for yy in range(cy, min(cy + ch, H)):
                for offset in range(2):
                    if cx + offset < W:
                        pixels[yy][cx + offset] = ACCENT_GOLD
                    if cx + cw - 1 - offset < W:
                        pixels[yy][cx + cw - 1 - offset] = ACCENT_GOLD
            for xx in range(cx, min(cx + cw, W)):
                for offset in range(2):
                    if cy + offset < H:
                        pixels[cy + offset][xx] = ACCENT_GOLD
                    if cy + ch - 1 - offset < H:
                        pixels[cy + ch - 1 - offset][xx] = ACCENT_GOLD
            # 카드 내 별
            draw_star(pixels, cx + cw // 2, cy + ch // 2,
                     min(cw, ch) // 4, min(cw, ch) // 10, 5, ACCENT_GOLD, W, H)

        elif elem_type == 'info_box':
            bx, by, bw, bh, color = elem[1], elem[2], elem[3], elem[4], elem[5]
            draw_rounded_rect(pixels, bx, by, bx + bw, by + bh, 12,
                            blend(color, BLACK, 0.7), W, H)
            # 상단 색상 바
            draw_rect(pixels, bx, by, bx + bw, by + 4, color, W, H)

        elif elem_type == 'button':
            bx, by, bw, bh = elem[1], elem[2], elem[3], elem[4]
            draw_rounded_rect(pixels, bx, by, bx + bw, by + bh, 24, ACCENT_GOLD, W, H)

        elif elem_type == 'star_row':
            sy, count = elem[1], elem[2]
            spacing = W // (count + 1)
            for i in range(count):
                sx = spacing * (i + 1)
                draw_star(pixels, sx, sy, 20, 8, 5, ACCENT_GOLD, W, H)

        elif elem_type == 'progress_bar':
            bx, by, bw, bh, fill = elem[1], elem[2], elem[3], elem[4], elem[5]
            color = elem[6] if len(elem) > 6 else ACCENT_GOLD
            draw_rounded_rect(pixels, bx, by, bx + bw, by + bh, 4,
                            (40, 30, 50), W, H)
            fill_w = int(bw * fill)
            draw_rounded_rect(pixels, bx, by, bx + fill_w, by + bh, 4,
                            color, W, H)

    # 하단 네비게이션 바
    nav_y = H - 120
    draw_rect(pixels, 0, nav_y, W, H, (20, 8, 35), W, H)
    draw_rect(pixels, 0, nav_y, W, nav_y + 1, (80, 60, 100), W, H)
    # 네비게이션 아이콘 (원형)
    nav_icons = 5
    spacing = W // nav_icons
    for i in range(nav_icons):
        nx = spacing // 2 + i * spacing
        draw_filled_circle(pixels, nx, nav_y + 50, 12,
                          ACCENT_GOLD if i == index else (80, 60, 100), W, H)

    path = os.path.join(SCRIPT_DIR, "screenshots", filename)
    create_png(W, H, pixels, path)


def generate_screenshots():
    # 스크린샷 1: 홈 화면
    print("Generating screenshot 1: Home...")
    generate_screenshot(0, "HOME", [
        ('card', 100, 380, W := 880, 260),
        ('star_row', 350, 3),
        ('card', 100, 720, 880, 260),
        ('info_box', 100, 1060, 880, 200, PRIMARY_PURPLE),
        ('button', 300, 1340, 480, 70),
    ], "screenshot_01_home.png")

    # 스크린샷 2: 카드 뽑기
    print("Generating screenshot 2: Card Draw...")
    generate_screenshot(1, "CARD DRAW", [
        ('card', 340, 400, 400, 640),
        ('star_row', 1150, 5),
        ('button', 340, 1200, 400, 70),
    ], "screenshot_02_card_draw.png")

    # 스크린샷 3: 카드 결과
    print("Generating screenshot 3: Card Result...")
    generate_screenshot(1, "CARD RESULT", [
        ('card', 340, 380, 400, 500),
        ('info_box', 80, 950, 920, 350, ACCENT_GOLD),
        ('button', 300, 1380, 480, 70),
    ], "screenshot_03_card_result.png")

    # 스크린샷 4: 운세
    print("Generating screenshot 4: Fortune...")
    generate_screenshot(2, "FORTUNE", [
        ('info_box', 80, 380, 920, 140, PRIMARY_PURPLE),
        ('info_box', 80, 560, 920, 200, (192, 57, 43)),
        ('progress_bar', 100, 710, 400, 10, 0.85, (231, 76, 60)),
        ('info_box', 80, 800, 920, 200, (39, 174, 96)),
        ('progress_bar', 100, 950, 400, 10, 0.72, (46, 204, 113)),
        ('info_box', 80, 1040, 920, 200, (41, 128, 185)),
        ('progress_bar', 100, 1190, 400, 10, 0.68, (52, 152, 219)),
        ('info_box', 80, 1280, 920, 200, (142, 68, 173)),
        ('progress_bar', 100, 1430, 400, 10, 0.90, (155, 89, 182)),
    ], "screenshot_04_fortune.png")

    # 스크린샷 5: 설정/프리미엄
    print("Generating screenshot 5: Settings...")
    generate_screenshot(4, "SETTINGS", [
        ('info_box', 80, 380, 920, 250, ACCENT_GOLD),
        ('button', 300, 540, 480, 60),
        ('info_box', 80, 700, 920, 80, (60, 40, 80)),
        ('info_box', 80, 800, 920, 80, (60, 40, 80)),
        ('info_box', 80, 900, 920, 80, (60, 40, 80)),
        ('info_box', 80, 1000, 920, 80, (60, 40, 80)),
        ('info_box', 80, 1100, 920, 80, (60, 40, 80)),
        ('info_box', 80, 1200, 920, 80, (60, 40, 80)),
    ], "screenshot_05_settings.png")


if __name__ == '__main__':
    print("=" * 50)
    print("Google Play Store 이미지 생성 시작")
    print("=" * 50)
    generate_icon()
    generate_feature_graphic()
    generate_screenshots()
    print("=" * 50)
    print("모든 이미지 생성 완료!")
    print(f"저장 위치: {SCRIPT_DIR}")
    print("=" * 50)
