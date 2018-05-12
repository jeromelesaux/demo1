; Exemple de raster élémentaire
; par OffseT pour Quasar CPC numéro 1
;
Org &5000
di
ld hl,(&38) 
ld (inter),hl 
ld hl,&c9fb 
ld (&38),hl 
ei
; Disable Interrupt
; On sauve les vieilles
; Interruptions
; On met les nouvelles
; EI et RET
; Enable Interrupt
; On sélectionne le Port B du PPI
; On pique son contenu
; On teste si le Bit0=1
; Si Bit0=0 alors on attend la fin
; du balayage
; On attend que le balayage arrive
; à peu près au milieu de l'écran
; Patience...
; Ouf, le dernier !
; On  se calle en début de ligne...
; On sélection le Gate Array
; HL pointe sur la table de couleurs
; On charge la couleur dans A
; Si A=255 alors...
; On saute au test clavier
; On sélectionne le border ;Ethoplà! ;Onlemetàlacouleur
; On sélectionne l'encre 0 ;Ethoplà! ;Onlametelleaussià la couleur ; On pointe sur la couleur suivante ; On attend la fin de la ligne...
; C'est reparti pour un tour !
Prog ld b,&f5 
Synchro in a,(c)
        rra
        jp nc,synchro
halt
halt
halt
halt
ds 20
ld b,&7f
ld hl,raster
Boucle ld a,(hl) cp 255
jp z,key 
ld c,16 
out (c),c 
out (c),a 
ld c,0 
out (c),c 
out (c),a 
inc hl
ds 32
jp boucle
;
; Test de la barre espace ;
Key ld bc,&f40e
out (c),c
ld bc,&f6c0 
out (c),c xor a
out (c),a
ld bc,&f792 
out (c),c
ld bc,&f645 
out (c),c
; No comment ici,
; c'est pas les rasters...
ld b,&f4
in a,(c)
ld bc,&f782 
out (c),c
ld bc,&f600 
out (c),c rla
jp c,prog
di
ld hl,(inter) 
ld (&38),hl ei
ret
;
; Les datas... ;
Inter dw 0000
; Bref, si pas espace alors
; on repart pour un tour...
; Disable Interrupt
; On récupère les anciennes
; interruptions
; Enable Interrupt
; Retour à la case départ
Raster  db 20+64,4+64,21+64,23+64,31+64,19+64,11+64
        db 3+64,10+64,14+64,12+64,28+64,20+64
        db 255