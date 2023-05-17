coded_file_size:
    dd  00001fbbh

opcode00000000_0000:
    dw  opcode00000000_0001
    dw  opcode80000000_0001

opcode00000000_0001:
    dw  opcode00000000_0002
    dw  opcode80000000_0002

opcode00000000_0002:
    dw  opcode00000000_0003
    dw  opcode80000000_0003

opcode00000000_0003:
    dw  opcode00000000_0004
    dw  opcode80000000_0004

opcode00000000_0004:
    db  02fh,0ffh,0ffh,0ffh

opcode80000000_0004:
    dw  opcode40000000_0005
    dw  opcodec0000000_0005

opcode40000000_0005:
    dw  opcode20000000_0006
    dw  opcodea0000000_0006

opcode20000000_0006:
    db  0ech,0ffh,0ffh,0ffh

opcodea0000000_0006:
    dw  opcode50000000_0007
    dw  opcoded0000000_0007

opcode50000000_0007:
    db  0efh,0ffh,0ffh,0ffh

opcoded0000000_0007:
    db  02ch,0ffh,0ffh,0ffh

opcodec0000000_0005:
    dw  opcode60000000_0006
    dw  opcodee0000000_0006

opcode60000000_0006:
    db  0e2h,0ffh,0ffh,0ffh

opcodee0000000_0006:
    db  0f2h,0ffh,0ffh,0ffh

opcode80000000_0003:
    dw  opcode40000000_0004
    dw  opcodec0000000_0004

opcode40000000_0004:
    dw  opcode20000000_0005
    dw  opcodea0000000_0005

opcode20000000_0005:
    db  0eeh,0ffh,0ffh,0ffh

opcodea0000000_0005:
    dw  opcode50000000_0006
    dw  opcoded0000000_0006

opcode50000000_0006:
    db  0ebh,0ffh,0ffh,0ffh

opcoded0000000_0006:
    dw  opcode68000000_0007
    dw  opcodee8000000_0007

opcode68000000_0007:
    dw  opcode34000000_0008
    dw  opcodeb4000000_0008

opcode34000000_0008:
    db  0f7h,0ffh,0ffh,0ffh

opcodeb4000000_0008:
    db  067h,0ffh,0ffh,0ffh

opcodee8000000_0007:
    db  062h,0ffh,0ffh,0ffh

opcodec0000000_0004:
    dw  opcode60000000_0005
    dw  opcodee0000000_0005

opcode60000000_0005:
    dw  opcode30000000_0006
    dw  opcodeb0000000_0006

opcode30000000_0006:
    db  063h,0ffh,0ffh,0ffh

opcodeb0000000_0006:
    db  06ch,0ffh,0ffh,0ffh

opcodee0000000_0005:
    dw  opcode70000000_0006
    dw  opcodef0000000_0006

opcode70000000_0006:
    db  064h,0ffh,0ffh,0ffh

opcodef0000000_0006:
    dw  opcode78000000_0007
    dw  opcodef8000000_0007

opcode78000000_0007:
    dw  opcode3c000000_0008
    dw  opcodebc000000_0008

opcode3c000000_0008:
    dw  opcode1e000000_0009
    dw  opcode9e000000_0009

opcode1e000000_0009:
    dw  opcode0f000000_000a
    dw  opcode8f000000_000a

opcode0f000000_000a:
    db  0f8h,0ffh,0ffh,0ffh

opcode8f000000_000a:
    db  0e6h,0ffh,0ffh,0ffh

opcode9e000000_0009:
    db  0f5h,0ffh,0ffh,0ffh

opcodebc000000_0008:
    db  0e1h,0ffh,0ffh,0ffh

opcodef8000000_0007:
    dw  opcode7c000000_0008
    dw  opcodefc000000_0008

opcode7c000000_0008:
    dw  opcode3e000000_0009
    dw  opcodebe000000_0009

opcode3e000000_0009:
    db  021h,0ffh,0ffh,0ffh

opcodebe000000_0009:
    db  077h,0ffh,0ffh,0ffh

opcodefc000000_0008:
    dw  opcode7e000000_0009
    dw  opcodefe000000_0009

opcode7e000000_0009:
    dw  opcode3f000000_000a
    dw  opcodebf000000_000a

opcode3f000000_000a:
    dw  opcode1f800000_000b
    dw  opcode9f800000_000b

opcode1f800000_000b:
    db  027h,0ffh,0ffh,0ffh

opcode9f800000_000b:
    db  07ch,0ffh,0ffh,0ffh

opcodebf000000_000a:
    dw  opcode5f800000_000b
    dw  opcodedf800000_000b

opcode5f800000_000b:
    db  0d4h,0ffh,0ffh,0ffh

opcodedf800000_000b:
    db  049h,0ffh,0ffh,0ffh

opcodefe000000_0009:
    db  045h,0ffh,0ffh,0ffh

opcode80000000_0002:
    dw  opcode40000000_0003
    dw  opcodec0000000_0003

opcode40000000_0003:
    dw  opcode20000000_0004
    dw  opcodea0000000_0004

opcode20000000_0004:
    dw  opcode10000000_0005
    dw  opcode90000000_0005

opcode10000000_0005:
    dw  opcode08000000_0006
    dw  opcode88000000_0006

opcode08000000_0006:
    db  0edh,0ffh,0ffh,0ffh

opcode88000000_0006:
    dw  opcode44000000_0007
    dw  opcodec4000000_0007

opcode44000000_0007:
    dw  opcode22000000_0008
    dw  opcodea2000000_0008

opcode22000000_0008:
    db  02bh,0ffh,0ffh,0ffh

opcodea2000000_0008:
    db  0fch,0ffh,0ffh,0ffh

opcodec4000000_0007:
    db  0f0h,0ffh,0ffh,0ffh

opcode90000000_0005:
    dw  opcode48000000_0006
    dw  opcodec8000000_0006

opcode48000000_0006:
    dw  opcode24000000_0007
    dw  opcodea4000000_0007

opcode24000000_0007:
    dw  opcode12000000_0008
    dw  opcode92000000_0008

opcode12000000_0008:
    db  06dh,0ffh,0ffh,0ffh

opcode92000000_0008:
    db  043h,0ffh,0ffh,0ffh

opcodea4000000_0007:
    db  068h,0ffh,0ffh,0ffh

opcodec8000000_0006:
    db  0f1h,0ffh,0ffh,0ffh

opcodea0000000_0004:
    dw  opcode50000000_0005
    dw  opcoded0000000_0005

opcode50000000_0005:
    dw  opcode28000000_0006
    dw  opcodea8000000_0006

opcode28000000_0006:
    dw  opcode14000000_0007
    dw  opcode94000000_0007

opcode14000000_0007:
    dw  opcode0a000000_0008
    dw  opcode8a000000_0008

opcode0a000000_0008:
    dw  opcode05000000_0009
    dw  opcode85000000_0009

opcode05000000_0009:
    dw  opcode02800000_000a
    dw  opcode82800000_000a

opcode02800000_000a:
    db  0d1h,0ffh,0ffh,0ffh

opcode82800000_000a:
    dw  opcode41400000_000b
    dw  opcodec1400000_000b

opcode41400000_000b:
    db  04bh,0ffh,0ffh,0ffh

opcodec1400000_000b:
    dw  opcode60a00000_000c
    dw  opcodee0a00000_000c

opcode60a00000_000c:
    db  07ah,0ffh,0ffh,0ffh

opcodee0a00000_000c:
    dw  opcode70500000_000d
    dw  opcodef0500000_000d

opcode70500000_000d:
    db  037h,0ffh,0ffh,0ffh

opcodef0500000_000d:
    db  0d7h,0ffh,0ffh,0ffh

opcode85000000_0009:
    db  042h,0ffh,0ffh,0ffh

opcode8a000000_0008:
    db  0ffh,0ffh,0ffh,0ffh

opcode94000000_0007:
    dw  opcode4a000000_0008
    dw  opcodeca000000_0008

opcode4a000000_0008:
    db  03eh,0ffh,0ffh,0ffh

opcodeca000000_0008:
    dw  opcode65000000_0009
    dw  opcodee5000000_0009

opcode65000000_0009:
    dw  opcode32800000_000a
    dw  opcodeb2800000_000a

opcode32800000_000a:
    db  050h,0ffh,0ffh,0ffh

opcodeb2800000_000a:
    db  04dh,0ffh,0ffh,0ffh

opcodee5000000_0009:
    db  0f4h,0ffh,0ffh,0ffh

opcodea8000000_0006:
    db  072h,0ffh,0ffh,0ffh

opcoded0000000_0005:
    dw  opcode68000000_0006
    dw  opcodee8000000_0006

opcode68000000_0006:
    db  03bh,0ffh,0ffh,0ffh

opcodee8000000_0006:
    dw  opcode74000000_0007
    dw  opcodef4000000_0007

opcode74000000_0007:
    db  070h,0ffh,0ffh,0ffh

opcodef4000000_0007:
    dw  opcode7a000000_0008
    dw  opcodefa000000_0008

opcode7a000000_0008:
    db  07bh,0ffh,0ffh,0ffh

opcodefa000000_0008:
    db  07dh,0ffh,0ffh,0ffh

opcodec0000000_0003:
    dw  opcode60000000_0004
    dw  opcodee0000000_0004

opcode60000000_0004:
    dw  opcode30000000_0005
    dw  opcodeb0000000_0005

opcode30000000_0005:
    dw  opcode18000000_0006
    dw  opcode98000000_0006

opcode18000000_0006:
    dw  opcode0c000000_0007
    dw  opcode8c000000_0007

opcode0c000000_0007:
    db  030h,0ffh,0ffh,0ffh

opcode8c000000_0007:
    db  0f3h,0ffh,0ffh,0ffh

opcode98000000_0006:
    dw  opcode4c000000_0007
    dw  opcodecc000000_0007

opcode4c000000_0007:
    db  0eah,0ffh,0ffh,0ffh

opcodecc000000_0007:
    dw  opcode66000000_0008
    dw  opcodee6000000_0008

opcode66000000_0008:
    db  0e9h,0ffh,0ffh,0ffh

opcodee6000000_0008:
    dw  opcode73000000_0009
    dw  opcodef3000000_0009

opcode73000000_0009:
    db  052h,0ffh,0ffh,0ffh

opcodef3000000_0009:
    db  079h,0ffh,0ffh,0ffh

opcodeb0000000_0005:
    dw  opcode58000000_0006
    dw  opcoded8000000_0006

opcode58000000_0006:
    db  06fh,0ffh,0ffh,0ffh

opcoded8000000_0006:
    dw  opcode6c000000_0007
    dw  opcodeec000000_0007

opcode6c000000_0007:
    dw  opcode36000000_0008
    dw  opcodeb6000000_0008

opcode36000000_0008:
    dw  opcode1b000000_0009
    dw  opcode9b000000_0009

opcode1b000000_0009:
    db  0e3h,0ffh,0ffh,0ffh

opcode9b000000_0009:
    db  078h,0ffh,0ffh,0ffh

opcodeb6000000_0008:
    dw  opcode5b000000_0009
    dw  opcodedb000000_0009

opcode5b000000_0009:
    dw  opcode2d800000_000a
    dw  opcodead800000_000a

opcode2d800000_000a:
    dw  opcode16c00000_000b
    dw  opcode96c00000_000b

opcode16c00000_000b:
    db  058h,0ffh,0ffh,0ffh

opcode96c00000_000b:
    db  0fdh,0ffh,0ffh,0ffh

opcodead800000_000a:
    db  0feh,0ffh,0ffh,0ffh

opcodedb000000_0009:
    db  032h,0ffh,0ffh,0ffh

opcodeec000000_0007:
    dw  opcode76000000_0008
    dw  opcodef6000000_0008

opcode76000000_0008:
    db  02dh,0ffh,0ffh,0ffh

opcodef6000000_0008:
    dw  opcode7b000000_0009
    dw  opcodefb000000_0009

opcode7b000000_0009:
    dw  opcode3d800000_000a
    dw  opcodebd800000_000a

opcode3d800000_000a:
    db  0f9h,0ffh,0ffh,0ffh

opcodebd800000_000a:
    dw  opcode5ec00000_000b
    dw  opcodedec00000_000b

opcode5ec00000_000b:
    db  033h,0ffh,0ffh,0ffh

opcodedec00000_000b:
    db  035h,0ffh,0ffh,0ffh

opcodefb000000_0009:
    db  05ch,0ffh,0ffh,0ffh

opcodee0000000_0004:
    dw  opcode70000000_0005
    dw  opcodef0000000_0005

opcode70000000_0005:
    db  065h,0ffh,0ffh,0ffh

opcodef0000000_0005:
    dw  opcode78000000_0006
    dw  opcodef8000000_0006

opcode78000000_0006:
    dw  opcode3c000000_0007
    dw  opcodebc000000_0007

opcode3c000000_0007:
    db  03dh,0ffh,0ffh,0ffh

opcodebc000000_0007:
    dw  opcode5e000000_0008
    dw  opcodede000000_0008

opcode5e000000_0008:
    dw  opcode2f000000_0009
    dw  opcodeaf000000_0009

opcode2f000000_0009:
    dw  opcode17800000_000a
    dw  opcode97800000_000a

opcode17800000_000a:
    dw  opcode0bc00000_000b
    dw  opcode8bc00000_000b

opcode0bc00000_000b:
    db  036h,0ffh,0ffh,0ffh

opcode8bc00000_000b:
    dw  opcode45e00000_000c
    dw  opcodec5e00000_000c

opcode45e00000_000c:
    dw  opcode22f00000_000d
    dw  opcodea2f00000_000d

opcode22f00000_000d:
    db  03fh,0ffh,0ffh,0ffh

opcodea2f00000_000d:
    db  0d6h,0ffh,0ffh,0ffh

opcodec5e00000_000c:
    dw  opcode62f00000_000d
    dw  opcodee2f00000_000d

opcode62f00000_000d:
    db  0c0h,0ffh,0ffh,0ffh

opcodee2f00000_000d:
    db  0d0h,0ffh,0ffh,0ffh

opcode97800000_000a:
    dw  opcode4bc00000_000b
    dw  opcodecbc00000_000b

opcode4bc00000_000b:
    db  041h,0ffh,0ffh,0ffh

opcodecbc00000_000b:
    dw  opcode65e00000_000c
    dw  opcodee5e00000_000c

opcode65e00000_000c:
    db  048h,0ffh,0ffh,0ffh

opcodee5e00000_000c:
    db  0c2h,0ffh,0ffh,0ffh

opcodeaf000000_0009:
    dw  opcode57800000_000a
    dw  opcoded7800000_000a

opcode57800000_000a:
    dw  opcode2bc00000_000b
    dw  opcodeabc00000_000b

opcode2bc00000_000b:
    db  04ch,0ffh,0ffh,0ffh

opcodeabc00000_000b:
    dw  opcode55e00000_000c
    dw  opcoded5e00000_000c

opcode55e00000_000c:
    db  0cfh,0ffh,0ffh,0ffh

opcoded5e00000_000c:
    db  055h,0ffh,0ffh,0ffh

opcoded7800000_000a:
    dw  opcode6bc00000_000b
    dw  opcodeebc00000_000b

opcode6bc00000_000b:
    dw  opcode35e00000_000c
    dw  opcodeb5e00000_000c

opcode35e00000_000c:
    db  056h,0ffh,0ffh,0ffh

opcodeb5e00000_000c:
    dw  opcode5af00000_000d
    dw  opcodedaf00000_000d

opcode5af00000_000d:
    db  0cah,0ffh,0ffh,0ffh

opcodedaf00000_000d:
    db  0c8h,0ffh,0ffh,0ffh

opcodeebc00000_000b:
    db  059h,0ffh,0ffh,0ffh

opcodede000000_0008:
    db  054h,0ffh,0ffh,0ffh

opcodef8000000_0006:
    db  0e8h,0ffh,0ffh,0ffh

opcode80000000_0001:
    dw  opcode40000000_0002
    dw  opcodec0000000_0002

opcode40000000_0002:
    db  020h,0ffh,0ffh,0ffh

opcodec0000000_0002:
    dw  opcode60000000_0003
    dw  opcodee0000000_0003

opcode60000000_0003:
    dw  opcode30000000_0004
    dw  opcodeb0000000_0004

opcode30000000_0004:
    dw  opcode18000000_0005
    dw  opcode98000000_0005

opcode18000000_0005:
    dw  opcode0c000000_0006
    dw  opcode8c000000_0006

opcode0c000000_0006:
    dw  opcode06000000_0007
    dw  opcode86000000_0007

opcode06000000_0007:
    db  0e4h,0ffh,0ffh,0ffh

opcode86000000_0007:
    dw  opcode43000000_0008
    dw  opcodec3000000_0008

opcode43000000_0008:
    db  022h,0ffh,0ffh,0ffh

opcodec3000000_0008:
    db  02eh,0ffh,0ffh,0ffh

opcode8c000000_0006:
    db  0e0h,0ffh,0ffh,0ffh

opcode98000000_0005:
    db  00ah,0ffh,0ffh,0ffh

opcodeb0000000_0004:
    dw  opcode58000000_0005
    dw  opcoded8000000_0005

opcode58000000_0005:
    db  00dh,0ffh,0ffh,0ffh

opcoded8000000_0005:
    dw  opcode6c000000_0006
    dw  opcodeec000000_0006

opcode6c000000_0006:
    dw  opcode36000000_0007
    dw  opcodeb6000000_0007

opcode36000000_0007:
    dw  opcode1b000000_0008
    dw  opcode9b000000_0008

opcode1b000000_0008:
    dw  opcode0d800000_0009
    dw  opcode8d800000_0009

opcode0d800000_0009:
    db  0f6h,0ffh,0ffh,0ffh

opcode8d800000_0009:
    dw  opcode46c00000_000a
    dw  opcodec6c00000_000a

opcode46c00000_000a:
    db  06bh,0ffh,0ffh,0ffh

opcodec6c00000_000a:
    db  02ah,0ffh,0ffh,0ffh

opcode9b000000_0008:
    db  0fbh,0ffh,0ffh,0ffh

opcodeb6000000_0007:
    dw  opcode5b000000_0008
    dw  opcodedb000000_0008

opcode5b000000_0008:
    db  0e7h,0ffh,0ffh,0ffh

opcodedb000000_0008:
    dw  opcode6d800000_0009
    dw  opcodeed800000_0009

opcode6d800000_0009:
    dw  opcode36c00000_000a
    dw  opcodeb6c00000_000a

opcode36c00000_000a:
    db  0b8h,0ffh,0ffh,0ffh

opcodeb6c00000_000a:
    db  03ah,0ffh,0ffh,0ffh

opcodeed800000_0009:
    dw  opcode76c00000_000a
    dw  opcodef6c00000_000a

opcode76c00000_000a:
    db  053h,0ffh,0ffh,0ffh

opcodef6c00000_000a:
    dw  opcode7b600000_000b
    dw  opcodefb600000_000b

opcode7b600000_000b:
    db  023h,0ffh,0ffh,0ffh

opcodefb600000_000b:
    db  034h,0ffh,0ffh,0ffh

opcodeec000000_0006:
    dw  opcode76000000_0007
    dw  opcodef6000000_0007

opcode76000000_0007:
    dw  opcode3b000000_0008
    dw  opcodebb000000_0008

opcode3b000000_0008:
    db  05dh,0ffh,0ffh,0ffh

opcodebb000000_0008:
    db  05bh,0ffh,0ffh,0ffh

opcodef6000000_0007:
    dw  opcode7b000000_0008
    dw  opcodefb000000_0008

opcode7b000000_0008:
    db  04fh,0ffh,0ffh,0ffh

opcodefb000000_0008:
    db  046h,0ffh,0ffh,0ffh

opcodee0000000_0003:
    dw  opcode70000000_0004
    dw  opcodef0000000_0004

opcode70000000_0004:
    dw  opcode38000000_0005
    dw  opcodeb8000000_0005

opcode38000000_0005:
    dw  opcode1c000000_0006
    dw  opcode9c000000_0006

opcode1c000000_0006:
    db  06eh,0ffh,0ffh,0ffh

opcode9c000000_0006:
    dw  opcode4e000000_0007
    dw  opcodece000000_0007

opcode4e000000_0007:
    db  028h,0ffh,0ffh,0ffh

opcodece000000_0007:
    db  029h,0ffh,0ffh,0ffh

opcodeb8000000_0005:
    dw  opcode5c000000_0006
    dw  opcodedc000000_0006

opcode5c000000_0006:
    db  0e5h,0ffh,0ffh,0ffh

opcodedc000000_0006:
    dw  opcode6e000000_0007
    dw  opcodeee000000_0007

opcode6e000000_0007:
    db  075h,0ffh,0ffh,0ffh

opcodeee000000_0007:
    dw  opcode77000000_0008
    dw  opcodef7000000_0008

opcode77000000_0008:
    dw  opcode3b800000_0009
    dw  opcodebb800000_0009

opcode3b800000_0009:
    dw  opcode1dc00000_000a
    dw  opcode9dc00000_000a

opcode1dc00000_000a:
    db  057h,0ffh,0ffh,0ffh

opcode9dc00000_000a:
    dw  opcode4ee00000_000b
    dw  opcodecee00000_000b

opcode4ee00000_000b:
    db  0ceh,0ffh,0ffh,0ffh

opcodecee00000_000b:
    dw  opcode67700000_000c
    dw  opcodee7700000_000c

opcode67700000_000c:
    dw  opcode33b80000_000d
    dw  opcodeb3b80000_000d

opcode33b80000_000d:
    db  0c3h,0ffh,0ffh,0ffh

opcodeb3b80000_000d:
    db  0c5h,0ffh,0ffh,0ffh

opcodee7700000_000c:
    db  026h,0ffh,0ffh,0ffh

opcodebb800000_0009:
    dw  opcode5dc00000_000a
    dw  opcodeddc00000_000a

opcode5dc00000_000a:
    db  038h,0ffh,0ffh,0ffh

opcodeddc00000_000a:
    db  03ch,0ffh,0ffh,0ffh

opcodef7000000_0008:
    dw  opcode7b800000_0009
    dw  opcodefb800000_0009

opcode7b800000_0009:
    db  044h,0ffh,0ffh,0ffh

opcodefb800000_0009:
    db  076h,0ffh,0ffh,0ffh

opcodef0000000_0004:
    dw  opcode78000000_0005
    dw  opcodef8000000_0005

opcode78000000_0005:
    dw  opcode3c000000_0006
    dw  opcodebc000000_0006

opcode3c000000_0006:
    dw  opcode1e000000_0007
    dw  opcode9e000000_0007

opcode1e000000_0007:
    db  073h,0ffh,0ffh,0ffh

opcode9e000000_0007:
    db  066h,0ffh,0ffh,0ffh

opcodebc000000_0006:
    dw  opcode5e000000_0007
    dw  opcodede000000_0007

opcode5e000000_0007:
    db  061h,0ffh,0ffh,0ffh

opcodede000000_0007:
    dw  opcode6f000000_0008
    dw  opcodeef000000_0008

opcode6f000000_0008:
    db  071h,0ffh,0ffh,0ffh

opcodeef000000_0008:
    dw  opcode77800000_0009
    dw  opcodef7800000_0009

opcode77800000_0009:
    dw  opcode3bc00000_000a
    dw  opcodebbc00000_000a

opcode3bc00000_000a:
    db  05fh,0ffh,0ffh,0ffh

opcodebbc00000_000a:
    db  025h,0ffh,0ffh,0ffh

opcodef7800000_0009:
    db  031h,0ffh,0ffh,0ffh

opcodef8000000_0005:
    dw  opcode7c000000_0006
    dw  opcodefc000000_0006

opcode7c000000_0006:
    db  074h,0ffh,0ffh,0ffh

opcodefc000000_0006:
    db  069h,0ffh,0ffh,0ffh

