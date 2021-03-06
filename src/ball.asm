  org #a000
  nolist
	write "ball"
	jp main ; main function 


Switch64k:
 di
 ld bc,#7FC7         ; copy C000-FFFF to 1C000-1FFFF
 out (c),c
 ld hl,#C000
 ld de,#4000
 ld bc,#4000
 ldir   

 ld bc,#7FC0         ; copy 4000-7FFF to C000-FFFF
 out (c),c
 ld hl,#4000
 ld de,#C000
 ld bc,#4000
 ldir   

 ld bc,#7FC5         ; copy C000-FFFF (4000-7FFF) to 14000-17FFF
 out (c),c
 ld hl,#4000
 ld de,#C000
 ld bc,#4000
 ldir   

 ld bc,#7FC3
 out (c),C
 ld  hl,#C000        ; copy the original videoram
 ld  de,#4000
 ld bc,#4000
 ldir

 ld bc,#7fc4   ; copy  0000-3FFF to 10000-13FFF
 out (c),c
 ld hl,#0000
 ld de,#4000
 ld bc,#4000
 ldir 
 
 ld bc,#7fc6 ; copy 8000-BFFF to 18000-1BFFF
 out (c),c
 ld hl,#8000
 ld de,#4000
 ld bc,#4000
 ldir        
 ld bc,#7fc2
 out (c),c     ; switch 64k
 ei
 ret   

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
  ; load and store file ball1 in bank 1
  ld bc,#7fc4
  out (c),c ; ram_4 in 4000-7fff
  ld de,#4000 ; buffer
  ld b,finball1-ball1
  ld hl,ball1 ; nom du fichier a charger
  call openfile

  ; load and store file ball2 in bank 2
   ld bc,#7fc5 
   out (c),c ; ram_5 in 4000-7fff
   ld de,#4000 ; buffer
   ld b,finball2-ball2
   ld hl,ball2 ; nom du fichier a charger
   call openfile

  ; load and store file ball3 in bank 3
  ld bc,#7fc6 
  out (c),c ; ram_6 in 4000-7fff
  ld de,#4000 ; buffer
  ld b,finball3-ball3
  ld hl,ball3 ; nom du fichier a charger
  call openfile

  ; load and store file ball4 in bank 4
  ld bc,#7fc7
  out (c),c ; ram_7 in 4000-7fff
  ld de,#4000 ; buffer
  ld b,finball4-ball4
  ld hl,ball4 ; nom du fichier a charger
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

ball1: 
  db "ball1.scr"
finball1

ball2: 
  db "ball2.scr"
finball2

ball3: 
  db "ball3.scr"
finball3

ball4: 
  db "ball4.scr"
finball4
