org #9000 
nolist
 xor a
 call #bc0e ; set mode 0 
 ld bc,0
 call #bc38  ; set border to black
; set color palette
 ld hl,palette
 xor a ; set 0 in a 
 loopcolors ld b,(hl)
 ld c,b
 call #bc32
 inc hl
 inc a
 cp 8
 jp z,loopcolors
ret

palette DB 0,26,9,13,6,3,12,24,25