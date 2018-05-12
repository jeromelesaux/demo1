;
; Gestion du mouvement des sprites hard
;
Org &8000 ; Implantation en &8000 Limit &8fff ; ou comme vous voulez Nolist ; du moment que ce n'est
; pas entre &4000 et &7FFF
Table Equ &9000 ; Adresse où lire la table
; de mouvement.
ld bc,&7fb8 ; Connexion de la page out (c),c ; I/O ASIC en &4000
Move ld ix,&6000 ; IX pointe sur le tableau ; ASIC des positions des
; sprites hard.
ld iy,spr ; IY pointe sur le tableau ; d'adresses de gestion du
; mouvement.
ld de,8 ; DE est l'incrément pour ; passer de l'adresse ASIC
; d'un sprite au suivant.
ld b,16 ; On va faire la boucle 16
LoopMov ld h,(iy+1) ; fois pour les 16 sprites
ld l,(iy+0) ; HL reçoit la première
ld a,(hl) ; adresse et A l'octet de
cp 255 ; poids faible de la position X
call z,rectif ; On teste si on est en fin de ld (ix+1),a ; table sinon on poke A sur la inc hl ; page I/O ASIC... On passe
ld a,(hl) ; ensuite @ l'octet de poids
ld (ix+0),a ; fort et on le met @ sa place inc hl ; sur la page I/O ASIC...
ld a,(hl) ; On fait de meme pour la
ld (ix+3),a ; position en Y du sprite
inc hl ; en lisant l'octet de poids
ld a,(hl) ; fort puis l'octet de poids
ld (ix+2),a ; faible et en les pokant sur inc hl ; la page I/O ASIC...
ld (iy+1),h ; On remet ensuite le tableau
ld (iy+0),l ; d'adresses @ jour pour le
inc iy ; prochain passage et on
inc iy ; pointe sur l'adresse pour le add ix,de ; sprite suivant...
djnz loopmov ; On boucle.
ld bc,&7fa0 ; On déconnecte la page out (c),c ; I/O ASIC et on revient ret ; au BASIC...
Rectif ld hl,table ; Si on est en fin de ld a,(hl) ; table alors on repointe
ret ; au début.
;
; Table d'adresses de gestion du mouvement
;
Spr dw table,table+16,table+32,table+48
 dw table+64,table+80,table+96,table+112
 dw table+128,table+144,table+160,table+176
 dw table+192,table+208,table+224,table+240