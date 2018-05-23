org #9000 
nolist
 xor a
 call #bc0e ; set mode 0 
 ld bc,#0000
 call #bc38  ; set border to black
 jp setpalette
 jp waitkey


setpalette
; set color palette
 ld hl,palette
 ld e,0
 loopcolors ld b,(hl)
 ld c,b
 ld a,e
 push de 
 push hl 
 call #bc32
 pop hl
 pop de
 inc hl
 inc e 
 bit 4,e
 ret nz
 jp loopcolors

palette DB 0,26,9,13,6,3,12,24,25

waitkey
  call #bb06
  ld h,0
  ld l,a
  ret 