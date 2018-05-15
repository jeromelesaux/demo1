  org #a000
  nolist
  write "card"
  jp main ; main function 


main: 
  ld a, 0
  call #bc0e ; set mode 0 
  
  ld hl,cardsprite ; adresse source du fichier charge .win
  ld de,#c000 ; adresse destination (ou l'on veut afficher l'image sur l'ecran)
  ld b,80 ; l'image contient x lignes de hauteur
  
  call loowin
  
  call waitkey
  ret

loowin:
  push bc ; on sauve le nombre de lignes
  push de ; et l'adresse ecran de depart
  ld bc,50 ; largeur de l'image
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


cardsprite: ; original file ../card.win 
 DB #00, #00, #00, #00, #00, #00, #00, #00
 DB #00, #00, #00, #00, #00, #00, #00, #00
 DB #00, #40, #80, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #40, #80, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #80
 DB #40, #80, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #80, #40, #80, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #40, #80
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #80, #40, #00, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #80, #40, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #80, #40
 DB #80, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #80, #40, #00, #40, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #80, #40, #40, #40
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #80
 DB #40, #40, #40, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #80, #40, #80, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #40, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #80, #40, #40, #40, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #80, #40, #40, #40, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #80, #40
 DB #00, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #80, #40, #00, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #80, #40, #40, #40
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #80
 DB #40, #40, #40, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c4, #c8, #c0, #c0, #c0, #c0
 DB #c0, #c0, #80, #40, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #98, #e0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #40, #00
 DB #40, #c0, #c0, #c0, #c0, #c0, #c0, #c4
 DB #64, #e0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #80, #40, #40, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #d0, #e0, #c4, #c0, #c0, #c0
 DB #c0, #c0, #c0, #80, #40, #00, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #90, #c8, #80
 DB #c0, #c0, #c0, #c0, #c0, #c0, #80, #40
 DB #40, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #98, #c8, #88, #c8, #c0, #c0, #c0, #c0
 DB #c0, #80, #40, #40, #c0, #c4, #40, #c0
 DB #c0, #c0, #c0, #10, #e0, #00, #40, #c0
 DB #c4, #e0, #c0, #c0, #80, #40, #00, #40
 DB #d0, #f0, #c0, #c0, #c0, #c4, #10, #60
 DB #00, #40, #c0, #d0, #a0, #c0, #c0, #80
 DB #40, #c0, #c0, #98, #d8, #c8, #c0, #c0
 DB #80, #10, #64, #c4, #c0, #c0, #00, #b0
 DB #c0, #c0, #80, #40, #c0, #c0, #b0, #88
 DB #e0, #c0, #c0, #88, #10, #30, #c0, #c0
 DB #c4, #20, #30, #c0, #c0, #80, #40, #00
 DB #c0, #98, #88, #60, #c0, #c0, #00, #10
 DB #30, #c8, #c0, #90, #20, #b0, #c0, #c0
 DB #80, #40, #40, #40, #c4, #88, #70, #c0
 DB #80, #00, #10, #30, #e0, #c0, #98, #00
 DB #cc, #c0, #c0, #80, #40, #40, #40, #c0
 DB #80, #b0, #c0, #80, #00, #10, #30, #60
 DB #c0, #30, #00, #c0, #c0, #c0, #80, #40
 DB #00, #c0, #c0, #80, #10, #e0, #80, #00
 DB #10, #30, #64, #c4, #70, #44, #c0, #c0
 DB #c0, #80, #40, #40, #40, #c0, #80, #10
 DB #70, #88, #00, #10, #30, #20, #90, #20
 DB #44, #c0, #c0, #c0, #80, #40, #40, #40
 DB #c0, #c4, #10, #30, #00, #00, #10, #30
 DB #70, #98, #20, #40, #c0, #c0, #c0, #80
 DB #40, #c0, #c0, #c0, #c4, #50, #30, #00
 DB #00, #10, #30, #30, #10, #20, #40, #c0
 DB #c0, #c0, #80, #40, #c0, #c0, #c0, #c0
 DB #00, #30, #00, #00, #10, #20, #10, #b0
 DB #00, #40, #c0, #c0, #c0, #80, #40, #c0
 DB #c0, #c0, #c0, #00, #30, #e0, #9c, #50
 DB #01, #80, #30, #00, #40, #c0, #c0, #c0
 DB #80, #40, #c0, #c0, #c0, #c0, #00, #10
 DB #14, #bc, #28, #bc, #6c, #a0, #00, #c8
 DB #c0, #c0, #c0, #80, #40, #c0, #c0, #c0
 DB #c0, #88, #00, #94, #40, #7c, #c8, #40
 DB #88, #44, #c0, #c0, #c0, #c0, #80, #40
 DB #c0, #c0, #c0, #c0, #80, #00, #80, #44
 DB #c4, #80, #40, #88, #40, #c0, #c0, #c0
 DB #c0, #80, #40, #c0, #c0, #c0, #c0, #c4
 DB #00, #c0, #88, #c0, #88, #c4, #88, #c8
 DB #c0, #c0, #c0, #c0, #80, #40, #c0, #c0
 DB #c0, #c0, #c0, #00, #cc, #cc, #c8, #40
 DB #cc, #00, #c0, #c0, #c0, #c0, #c0, #80
 DB #40, #c0, #c0, #c0, #c0, #c0, #c8, #c8
 DB #00, #00, #00, #cc, #c4, #c0, #c0, #c0
 DB #c0, #c0, #80, #40, #c0, #c0, #c0, #c0
 DB #c0, #c8, #cc, #cc, #44, #88, #cc, #cc
 DB #c0, #c0, #c0, #c0, #c0, #80, #40, #c0
 DB #c0, #c0, #c0, #c0, #c8, #c4, #88, #c8
 DB #88, #c8, #c4, #c0, #c0, #c0, #c0, #c0
 DB #80, #40, #c0, #c0, #c0, #c0, #c0, #cc
 DB #c0, #cc, #c8, #cc, #c8, #c4, #c0, #c0
 DB #c0, #c0, #c0, #80, #40, #c0, #c0, #c0
 DB #c0, #c0, #88, #c0, #cc, #c8, #88, #c8
 DB #80, #c0, #c0, #c0, #c0, #c0, #80, #40
 DB #c0, #c0, #c0, #c0, #c0, #80, #c4, #c4
 DB #c8, #c8, #c0, #c4, #c0, #c0, #c0, #c0
 DB #c0, #80, #40, #c0, #c0, #c0, #c0, #c0
 DB #80, #c4, #c8, #c0, #c8, #40, #c4, #c0
 DB #c0, #c0, #c0, #c0, #80, #40, #c0, #c0
 DB #c0, #c0, #8c, #0c, #c0, #00, #44, #00
 DB #cc, #84, #08, #c8, #c0, #c0, #c0, #80
 DB #40, #c0, #c0, #c0, #c4, #0c, #0c, #c0
 DB #00, #00, #00, #c4, #84, #0c, #4c, #c0
 DB #c0, #c0, #80, #40, #c0, #c0, #c0, #04
 DB #0c, #0c, #c8, #88, #c8, #80, #c0, #04
 DB #0c, #0c, #c0, #c0, #c0, #80, #40, #c0
 DB #c0, #c4, #0c, #0c, #0c, #40, #80, #44
 DB #88, #c4, #04, #0c, #0c, #40, #c0, #c0
 DB #80, #40, #c0, #c0, #80, #0c, #0c, #0c
 DB #4c, #80, #00, #00, #80, #0c, #0c, #0c
 DB #4c, #c0, #c0, #80, #40, #c0, #c0, #84
 DB #0c, #0c, #0c, #08, #c4, #00, #40, #8c
 DB #0c, #0c, #0c, #08, #c0, #c0, #80, #40
 DB #c0, #c0, #84, #0c, #08, #0c, #0c, #c8
 DB #00, #c8, #04, #0c, #08, #0c, #08, #c0
 DB #c0, #80, #40, #c0, #c0, #88, #0c, #cc
 DB #0c, #0c, #40, #c0, #c8, #0c, #0c, #40
 DB #8c, #08, #c0, #c0, #80, #40, #c0, #c0
 DB #00, #44, #80, #0c, #0c, #48, #c0, #c4
 DB #0c, #0c, #48, #c4, #00, #40, #c0, #80
 DB #40, #c0, #c0, #00, #c0, #04, #0c, #0c
 DB #08, #3c, #8c, #0c, #0c, #0c, #c8, #00
 DB #40, #c0, #80, #40, #c0, #c0, #00, #c0
 DB #0c, #0c, #0c, #0c, #00, #04, #0c, #0c
 DB #0c, #40, #88, #40, #c0, #80, #40, #c0
 DB #c0, #c0, #c4, #0c, #0c, #0c, #0c, #0c
 DB #0c, #0c, #0c, #0c, #48, #c0, #c0, #c0
 DB #80, #40, #c0, #c0, #c0, #8c, #0c, #0c
 DB #0c, #0c, #0c, #0c, #0c, #0c, #0c, #08
 DB #c0, #c0, #c0, #80, #40, #c0, #c0, #c0
 DB #04, #0c, #0c, #04, #0c, #0c, #0c, #08
 DB #04, #0c, #0c, #c0, #c0, #c0, #80, #40
 DB #c0, #c0, #c0, #0c, #0c, #4c, #80, #0c
 DB #0c, #0c, #48, #80, #0c, #0c, #c0, #c0
 DB #c0, #80, #40, #c0, #c0, #c0, #0c, #0c
 DB #c8, #c4, #0c, #0c, #0c, #40, #c4, #0c
 DB #0c, #c0, #c0, #c0, #80, #40, #c0, #c0
 DB #c0, #0c, #0c, #c0, #c4, #0c, #0c, #0c
 DB #40, #c0, #0c, #0c, #c0, #c0, #c0, #80
 DB #40, #c0, #c0, #c0, #0c, #0c, #c0, #c4
 DB #0c, #0c, #0c, #40, #c0, #0c, #0c, #c0
 DB #80, #c0, #80, #40, #c0, #c0, #c0, #0c
 DB #0c, #c0, #c0, #0c, #0c, #0c, #c8, #c0
 DB #8c, #0c, #c0, #80, #c0, #80, #40, #c0
 DB #c0, #c0, #04, #4c, #c0, #c0, #0c, #0c
 DB #0c, #c8, #c0, #8c, #0c, #c0, #80, #c0
 DB #80, #40, #c0, #c0, #c0, #a0, #40, #c0
 DB #c0, #0c, #0c, #0c, #c8, #c0, #80, #50
 DB #c0, #80, #c0, #80, #40, #c0, #c0, #c0
 DB #30, #c0, #c0, #c0, #04, #0c, #0c, #c0
 DB #c0, #c0, #98, #c8, #80, #00, #80, #40
 DB #c0, #c0, #c0, #30, #c0, #c0, #c0, #8c
 DB #0c, #0c, #c0, #c0, #c0, #10, #c8, #c0
 DB #c0, #80, #40, #c0, #c0, #c0, #f0, #c0
 DB #c0, #c0, #84, #0c, #08, #c0, #c0, #c0
 DB #98, #c8, #c0, #40, #80, #40, #c0, #c0
 DB #c0, #cc, #c0, #c0, #c0, #80, #0c, #44
 DB #c0, #c0, #c0, #c4, #c0, #80, #80, #80
 DB #40, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #00, #c8, #c0, #c0, #c0, #c0, #c0
 DB #80, #80, #80, #40, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #00, #c8, #c0, #c0
 DB #c0, #c0, #c0, #80, #80, #80, #40, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #00
 DB #40, #c0, #c0, #c0, #c0, #c0, #c0, #40
 DB #80, #40, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #00, #c8, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #80, #40, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #80, #80, #80, #40
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #00, #80, #40, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #80, #00, #80, #40, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #80, #80
 DB #40, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #80, #80, #80, #40, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #40, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #80, #00
 DB #80, #40, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #80, #80, #40, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #00, #80, #40
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #80, #80, #40, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #80, #80, #40, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #00, #80
 DB #40, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #80, #40, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #40, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #00
 DB #80, #40, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #80, #80, #80, #40, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #80, #80, #80, #40
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #00, #80, #40, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #80, #80, #80, #80, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #c0, #c0, #c0
 DB #c0, #c0, #c0, #c0, #c0, #80, #80, #c0
 DB #c0, #00, #00, #00, #00, #00, #00, #00
 DB #00, #00, #00, #00, #00, #00, #00, #00
 DB #00, #00, #40, #04, #94, #00, #64, #00
