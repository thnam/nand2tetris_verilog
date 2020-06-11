#!/usr/bin/env python3
with open("rtl/rom_content.txt", 'w') as f:
    seed = 1
    for i in range(2**15):
        f.write(f"{seed + 2*i:016b}\n")
