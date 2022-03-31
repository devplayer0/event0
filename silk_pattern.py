#!/usr/bin/env python3
import pixie

# This script is a hacky piece of shit...

size = 2048

font = pixie.read_font('/usr/share/fonts/noto/NotoSansMono-Bold.ttf')
font.size = size // 16
font.paint.color = pixie.Color(1, 1, 1, 1)

image = pixie.Image(size, size)

for i in range(32):
	image.fill_text(font, '/dev/input/event0 '*12, transform=pixie.translate(-i*3*font.size, i*1.1*font.size))

image.write_file('pattern.png')
