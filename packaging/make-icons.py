#!/usr/bin/env python3
"""Generates every platform's app icon from one definition.

Run from the project root after changing the artwork:

    python3 packaging/make-icons.py

Why the artwork is drawn here rather than scaled from a PNG: the source was a
256px image, and macOS wants 1024px. Upscaling that is visibly soft, and the
icon is the first thing anyone sees of the app. Drawing it at each target size
keeps the cross crisp everywhere, and makes the shape a few lines to adjust
rather than a binary to re-export.

Outputs:
    packaging/icon.png                    Linux menu icon, and the .deb
    windows/runner/resources/app_icon.ico 7 sizes, 16-256
    macos/.../AppIcon.appiconset/*.png    the sizes Xcode expects
    web/icons/*.png, web/favicon.png      PWA and browser tab
"""

import pathlib
from PIL import Image, ImageDraw

ROOT = pathlib.Path(__file__).resolve().parent.parent

# Near-black rather than pure black, matching the app's dark surface.
BACKGROUND = (26, 26, 26, 255)
FOREGROUND = (255, 255, 255, 255)


def draw(size: int, *, rounded: bool = True, bleed: bool = False) -> Image.Image:
    """A cross on a rounded square, drawn at `size` px.

    `bleed` fills the whole canvas instead of insetting the square: Android and
    the web ask for "maskable" icons that they crop to their own shape, and an
    icon with transparent corners gets a visible gap once cropped.
    """
    # Supersample, then downscale — the cheapest way to get clean curves and
    # edges without hand-written antialiasing.
    scale = 4
    px = size * scale
    img = Image.new('RGBA', (px, px), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    if bleed:
        d.rectangle([0, 0, px, px], fill=BACKGROUND)
    elif rounded:
        # ~22% corner radius reads as a rounded square at every size without
        # looking like a circle.
        d.rounded_rectangle([0, 0, px - 1, px - 1], radius=int(px * 0.22),
                            fill=BACKGROUND)
    else:
        d.rectangle([0, 0, px, px], fill=BACKGROUND)

    # A Latin cross: the crossbar sits above centre, as it is drawn in practice.
    bar = px * 0.13          # stroke width
    top = px * 0.20
    bottom = px * 0.80
    cx = px / 2
    arm = px * 0.20          # half the crossbar width
    crossbar_y = px * 0.38

    d.rectangle([cx - bar / 2, top, cx + bar / 2, bottom], fill=FOREGROUND)
    d.rectangle([cx - arm, crossbar_y - bar / 2, cx + arm, crossbar_y + bar / 2],
                fill=FOREGROUND)

    return img.resize((size, size), Image.LANCZOS)


def write(path: pathlib.Path, image: Image.Image) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path)
    print(f'  {path.relative_to(ROOT)}  {image.size[0]}px')


def main() -> None:
    print('Linux')
    write(ROOT / 'packaging/icon.png', draw(512))
    # The sizes the freedesktop icon theme looks for. Installing only 256 makes
    # GNOME downscale for the 32px window list and the dock, which is softer
    # than a purpose-drawn frame.
    for size in [16, 24, 32, 48, 64, 128, 256, 512]:
        write(ROOT / f'packaging/icons/{size}.png', draw(size))

    print('Windows')
    ico = ROOT / 'windows/runner/resources/app_icon.ico'
    ico.parent.mkdir(parents=True, exist_ok=True)
    # Every size Windows picks from: 16 for the title bar and tray, 32 for the
    # desktop, 48 in file lists, 256 for large tiles. Shipping only 256 makes
    # Windows downscale on the fly, which looks worst at 16px.
    sizes = [16, 24, 32, 48, 64, 128, 256]
    frames = [draw(s) for s in sizes]
    frames[-1].save(ico, format='ICO',
                    sizes=[(s, s) for s in sizes],
                    append_images=frames[:-1])
    print(f'  {ico.relative_to(ROOT)}  {", ".join(str(s) for s in sizes)}px')

    print('macOS')
    for size in [16, 32, 64, 128, 256, 512, 1024]:
        write(
            ROOT / 'macos/Runner/Assets.xcassets/AppIcon.appiconset'
                 / f'app_icon_{size}.png',
            draw(size),
        )

    print('Web')
    write(ROOT / 'web/favicon.png', draw(64))
    for size in [192, 512]:
        write(ROOT / f'web/icons/Icon-{size}.png', draw(size))
        # Maskable variants bleed to the edges so a launcher can crop them to
        # any shape without exposing transparent corners.
        write(ROOT / f'web/icons/Icon-maskable-{size}.png',
              draw(size, bleed=True))


if __name__ == '__main__':
    main()
