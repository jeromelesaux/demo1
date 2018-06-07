  org #a000
  nolist
	jp main ; main function 

; set color and mode screen
setcolors:
ld a,0
call #bc0e ; set mode 0 
ld a,0
ld b,1
call #bc32
ld a,13
ld b,2
call #bc32
ld b,0
call #bc38
ret

;--------------------------------------------
initamsdos: ; initialisation de la rom 7 (usage du disque)
	ld hl,(#be7d); recup du numero de lecteur dans a
	ld a,(hl)
	push af
	ld c,7 ; init rom 7
	ld de,#40
	ld hl,#abff
	call #bcce
	pop af
	ld hl,(#be7d) ; restit du numero de lecteur
	ld (hl),a
  ret 
;--------------------------------------------
openfile: 
  call #bc77
  ld hl,#4000 ; adresse de debut du fichier
  call #bc83 ; read all content in memory
  call #bc7a ; close file 
  ret	
;--------------------------------------------

cpyscreen: ; copy 4000-7fff to C000-ffff
  ld hl,#4000 ;
  ld de,#c000 ; c4 = bank 1 | c5 = bank 2 | c6 = bank 3 | c7 = bank 4
  ld bc,#4000
  ldir
  ret	

main: 
  call initamsdos
  call setcolors

  di
  ; load and store file whole1 in bank 1
  ld bc,#7fc4
  out (c),c ; ram_4 in 4000-7fff
  ld de,#4000 ; buffer
  ld b,finwhole1-whole1
  ld hl,whole1 ; nom du fichier a charger
  call openfile

  ; load and store file whole2 in bank 2
   ld bc,#7fc5 
   out (c),c ; ram_5 in 4000-7fff
   ld de,#4000 ; buffer
   ld b,finwhole2-whole2
   ld hl,whole2 ; nom du fichier a charger
   call openfile

  ; load and store file whole3 in bank 3
  ld bc,#7fc6 
  out (c),c ; ram_6 in 4000-7fff
  ld de,#4000 ; buffer
  ld b,finwhole3-whole3
  ld hl,whole3 ; nom du fichier a charger
  call openfile

  ; load and store file whole4 in bank 4
  ld bc,#7fc7
  out (c),c ; ram_7 in 4000-7fff
  ld de,#4000 ; buffer
  ld b,finwhole4-whole4
  ld hl,whole4 ; nom du fichier a charger
  call openfile

  ld bc,#7fc0 ; restore RAM_0 in 0000-FFFF
  out (c),c
  ei
 
  call waitkey
  di
loopanim: 
  ld bc,#7fc4
  out (c),c ; ram_4 in 4000-7fff
  call cpyscreen
  ld bc,#7fc5 
  out (c),c ; ram_5 in 4000-7fff
  call cpyscreen
  ld bc,#7fc6 
  out (c),c ; ram_6 in 4000-7fff
  call cpyscreen
  ld bc,#7fc7
  out (c),c ; ram_7 in 4000-7fff
  call cpyscreen
  ld bc,#7fc6 
  out (c),c ; ram_6 in 4000-7fff
  call cpyscreen
  ld bc,#7fc5 
  out (c),c ; ram_5 in 4000-7fff
  call cpyscreen
  jp loopanim
  ei

  ret	

waitkey: 
  call #bb06
  ld h,0
  ld l,a
  ret 

whole1: 
  db "whole1.scr"
finwhole1

whole2: 
  db "whole2.scr"
finwhole2

whole3: 
  db "whole3.scr"
finwhole3

whole4: 
  db "whole4.scr"
finwhole4

save 'wh.bin',#a000,1024,DSK,'fichiertest.dsk'
