  org #3000
  nolist
	write "demo"
	jp main ; main function 
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

cpyscreen:
  ld hl,#4000 ;
  ld de,#8000 ; c4 = bank 1 | c5 = bank 2 | c6 = bank 3 | c7 = bank 4
  ld bc,#4000
  ldir
  ret	

main: 
  call initamsdos

  ; load and store file hypto1 in bank 1
  ld bc,#7fc4
  out (c),c
  ld de,#8000 ; buffer
  ld b,finhypto1-hypto1
  ld hl,hypto1 ; nom du fichier a charger
  call openfile
  call cpyscreen

  ; ld a,2
  ; call #bb5a
  ; ; load and store file hypto2 in bank 2
  ; ld bc,#7fc5
  ; out (c),c
  ; ld de,#8000 ; buffer
  ; ld b,finhypto2-hypto2
  ; ld hl,hypto2 ; nom du fichier a charger
  ; call openfile
  ; call cpyscreen


  ; ld a,3
  ; call #bb5a
  ; ; load and store file hypto3 in bank 3
  ; ld bc,#7fc6
  ; out (c),c
  ; ld de,#8000 ; buffer
  ; ld b,finhypto3-hypto3
  ; ld hl,hypto3 ; nom du fichier a charger
  ; call openfile
  ; call cpyscreen


  ; ld a,4
  ; call #bb5a
  ; ; load and store file hypto4 in bank 4
  ; ld bc,#7fc7
  ; out (c),c
  ; ld de,#8000 ; buffer
  ; ld b,finhypto4-hypto4
  ; ld hl,hypto4 ; nom du fichier a charger
  ; call openfile
  ; call cpyscreen

  ld bc,#7fc0
  out (c),c

  call waitkey
  ret	

waitkey: 
  call #bb06
  ld h,0
  ld l,a
  ret 

hypto1: 
  db "hypto1.scr"
finhypto1

hypto2: 
  db "hypto2.scr"
finhypto2

hypto3: 
  db "hypto1.scr"
finhypto3

hypto4: 
  db "hypto1.scr"
finhypto4









