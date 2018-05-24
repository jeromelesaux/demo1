org #9000 
nolist
 xor a
 call #bc0e ; set mode 0 
 ld bc,#0000
 call #bc38  ; set border to black
 call setpalette
 call waitkey


setpalette
; set color palette
 ld hl,palette ; table des couleurs
 ld e,0 ; depart pen 0
loopcol ld b,(hl) ; recupere couleur dans b
 ld c,b ; c=b donc même couleur
 ld a,e ; on se sert du registre compteur e pour gerer le numero d'encre
 push de:push hl ; on sauvegarde les registres modifié par le vecteur
 call #bc32 ; Appel du vecteur Systeme SCR_SET_INK
 pop hl:pop de ; on restitue ces registres
 inc hl ; prochaine couleur
 inc e ; 1 couleur de moins
 bit 4,e ; teste si 16eme couleur
 ret nz ; on est arrive
 jr loopcol ; sinon on continue

palette DB 0,26,9,13,6,3,12,24,25

waitkey
  call #bb06
  ret 