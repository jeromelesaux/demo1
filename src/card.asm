  org #a000
  nolist
  write "poker"
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



cardfile:
    db "card.win"
endcardfile

main: 
 ld a, 0
 call #bc0e ; set mode 0 
  call initamsdos
  di
  ld de,#4000 ; buffer
  ld b,endcardfile - cardfile
  ld hl,cardfile ; nom du fichier a charger
  call openfile
  call waitkey
  ld hl,#4000 ; adresse source du fichier charge .win
  ld de,#c000 ; adresse destination (ou l'on veut afficher l'image sur l'ecran)
  ld b,#c4 ; l'image contient x lignes de hauteur
  call loowin
  call waitkey
  ei
  ret

loowin:
  push bc ; on sauve le nombre de lignes
  push de ; et l'adresse ecran de depart
  ld bc,#c8 ; largeur de l'image
  ldir               ; on copie tout
  pop de          ; on recupere l'adresse ecran (1ere ligne) afin de calculer la prochaine adresse ecran
  call mybc26   ; on calcule la ligne suivante
  pop bc          ; on recupere le nombre de lignes sauves plus haut
  djnz loowin   ; on reboucle tant que le nombre de ligne <>0
  ret
;
mybc26:
  ld a,d       ; on recupere le poids fort du registre d
  add a,8     
  ld d,a       ; on remet la bonne valeur a d
  ret nc       ; on s'arrete ici si pas de depassement (a>#ff)
  ex hl,de   ; on inverse le contenu des registres HL et De
  ld bc,#c050 ; prochaine ligne si ecran de 80 caracteres
  add hl,bc     ; on a ici la prochaine ligne apres calcul
  ex hl,de    ; on remets les valeurs de registres HL et DE a leur place
  ret

  

waitkey: 
  call #bb06
  ld h,0
  ld l,a
  ret 
