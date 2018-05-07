  org #4000
  nolist
	write "demo"
	jp main ; main function 

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

openfile: 
	ld b,finhypto1-hypto1
  ld hl,hypto1 ; nom du fichier a charger
  ld de,#c000 ; buffer
  call #bc77
  ld hl,#c000 ; adresse de dzbut du fichier
  call #bc83 ; read all content in memory
  call #bc7a ; close file 

main: 
  call initamsdos
  call openfile

waitkey: 
  call #bb06
  ld h,0
  ld l,a
  call #0 ; reset cpc

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









