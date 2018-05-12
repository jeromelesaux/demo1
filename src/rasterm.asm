;
; Programme d'exemple de mise en mouvement d'un raster avec un tableau
; De plus ce programme restitue des couleurs (à modifier dans "Image")
; pour donner l'illusion qu'une image s'affiche sous le raster...
; En deux mots c'est pratiquement le meme programme que celui de l'intro
; du menu principal de Quasar.
;
; Note...vous remarquerez que le tableau est stocke a l'envers,
;
; etrange non ?
Org &8000
Ent
Nolist
Long Equ 12
; Long = nbre de lignes du raster +
;
; Adieu les interruptions !!!
;
di ; Tout ceci sert a installer un
ld hl,(&38) ; EI, RET
ld (inter),hl ; en &38 pour eviter d'utiliser des ld hl,&c9fb ; HALT et pouvoir donc se
ld (&38),hl ; synchroniser sur les interruptions

Prog ld b,&f5 
Synchro in a,(c)
rra
jp nc,synchro ; puis on se barre !
ds 36
ld hl,image 
ld bc,&7f00 
out (c),c 
outi
inc b
inc c
out (c),c 
outi
inc b
inc c
out (c),c 
outi
inc b
inc c
out (c),c 
outi
inc b
; On attend le debut de la ligne ; suivante (synchro horizontale) ; On selectionne le papier ;Ethop!
; On envoie les couleurs de l'image ; Encre 0
;Hop!
; Encre 1
;Hop!
; C'est pas fini !
; Patience...
; Encre 2
;Hop!
; La fin approche...
; Encre 3
;Hopla!
; C'est fini...
; On remet b comme il faut...
ld hl,tableau ; On pointe sur la tableau
Loop2
ld a,(hl) 
cp 0
jp z,suite 
ld c,16 
out (c),c 
out (c),a 
ld c,0
out (c),c 
out (c),a 
inc hl
ds 32
jp loop2
; Hop !
; Si 0 Alors fin raster donc... ; On passe a la suite !
; Selection du Border
;Hop!
; Modif du border
; Selection de l'encre 0
; Modif de l'encre 0
;Hop!
; On passe a la ligne suivante ; Patience...
; C'est reparti pour un tour...
; On remet tout a zero ; Encre 1
;Hop!
; Zero
; Encre 2 ;Hop!
; Zero
; Encre 3
Suite ld a,64+20 
ld c,1
out (c),c 
out (c),a 
inc c
out (c),c 
out (c),a 
inc c

; On attend le debut de la ligne ; suivante (synchro horizontale) ; On selectionne le papier ;Ethop!
; On envoie les couleurs de l'image ; Encre 0
;Hop!
; Encre 1
;Hop!
; C'est pas fini !
; Patience...
; Encre 2
;Hop!
; La fin approche...
; Encre 3
;Hopla!
; C'est fini...
; On remet b comme il faut...
out (c),c
out (c),a
xor a
ld hl,(courant); reinitialiser le tableau ld b,long ; juste ou il le faut...
ld b,long
;Hop!
; Zero
; On se prepare pour
Loop3 ld (hl),20+64 ; C'est tout bete
dec hl ; Une petit boucle djnz loop3 ; s'occupe de tout ! ld hl,(courant); On passe a la ligne inc hl ; suivante...
djnz loop3
ld hl,(courant); On passe a la ligne inc hl ; suivante...
ld (courant),hl; On sauve pour savoir ou
cp (hl)
jp z,fin
ld de,raster 
ld b,long
Loop1 ld a,(de) 
ld (hl),a
inc de
dec hl 
djnz loop1 jp 
prog
Fin ei
ld hl,(inter) ; On restitue le systeme ld (&38),hl ; proprement avant de ret ; partir...
ld (&38),hl ; proprement avant de ret
;
; Datas ;
; Couleurs de l'image a restituer (MODE 1)
Image   db 64+20,64+30,64+10,64+14
; Raster a faire defiler...Attention !
; Il doit commancer par zero et les
; couleurs doivent etre mise a l'envers ! Raster db 0
        db 64+20,64+4,64+21,64+23,64+31,64+19
        db 64+11,64+10,64+14,64+12,64+28
; Le tableau ou l'on stockera le raster
Tableau db 0
        ds 310,64+20
db 0
; on en est au prochain coup !
; Si fin tableau bye !
; Sinon on y sauve le raster...
; Ne me demandez pas pourquoi
; je n'ai pas fait avec LDDR ou
; LDIR car se serais trop long a
; expliquer...
; Vous comprendrez bien par
; meme...
; On repart pour une VBL !
; Ici, pas de miracle
; Sauvegarde Interruptions
Inter dw 0000
; Pointeur du tableau
Courant dw tableau+long-1