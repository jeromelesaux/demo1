	org &4000
	nolist
	write "demo"
	jp main

initamsdos:
	ld hl,(&be7d); recup du numero de lecteur dans a
	ld a,(hl)
	push af
	ld c,7 ; init rom 7
	ld de,&40
	ld hl,&abff
	call &bcce
	pop af
	ld hl,(&be7d) ; restit du numero de lecteur
	ld (hl),a
L1:
	ret
openread:
	pop bc
	pop de
	pop hl
	push hl
	push de
	push bc
	call getfilenamesize
	call &bc77
	jr nc, openreadfail
	ld hl, 1
	ret
openreadfail:
	ld hl, 0
	ret
L2:
	ret
getchar:
	call &bc80
	ld h, 0
	ld l, a
	ret
L3:
	ret
iseof:
	call &bc89
	jr nc, iseoftrue
	ld hl, 0
	ret
iseoftrue:
	ld hl, 1
	ret
L4:
	ret
closeread:
	call &bc7a
L5:
	ret
openwrite:
	pop bc
	pop de
	pop hl
	push hl
	push de
	push bc
	call getfilenamesize
	call &bc8c
	jr nc, openwritefail
	ld hl, 1
	ret
openwritefail:
	ld hl, 0
	ret
L6:
	ret
putchar:
	pop bc
	pop hl
	push hl
	push bc
	ld a, l
	call &bc95
L7:
	ret
getbinary:
	pop bc
	pop hl
	push hl
	push bc
	call &bc83
L8:
	ret
putstr:
	pop bc
	pop hl
	push hl
	push bc
putstrloop:
	ld a, ( hl )
	or a
	ret z
	call &bc95
	inc hl
	jp putstrloop
L9:
	ret
putstrln:
	pop bc
	pop hl
	push hl
	push bc
putstrlnloop:
	ld a, ( hl )
	or a
	jp z, putstrlnend
	call &bc95
	inc hl
	jp putstrlnloop
putstrlnend:
	ld a, 13
	call &bc95
	ld a, 10
	call &bc95
L10:
	ret
putbinary:
	pop ix
	pop bc
	pop de
	pop hl
	push hl
	push de
	push bc
	push ix
	ld a, 2 ; binary
	call &bc98
L11:
	ret
closewrite:
	call &bc8f
L12:
	ret
getfilenamesize:
	push de
	push hl
	ld e, 0
getfilenamesizeloop:
	ld a, (hl)
	or a
	jp z, getfilenamesizeend
	inc hl
	inc e
	jp getfilenamesizeloop
getfilenamesizeend:
	pop hl
	ld b, e
	pop de
	ret
printstr:
	pop bc
	pop hl
	push hl
	push bc
printstrloop:
	ld a, ( hl )
	or a
	ret z
	call &bb5a
	inc hl
	jp printstrloop
L13:
	ret
printstrln:
	pop bc
	pop hl
	push hl
	push bc
printstrlnloop:
	ld a, ( hl )
	or a
	jp z, printstrlnend
	call &bb5a
	inc hl
	jp printstrlnloop
printstrlnend:
	ld a, 13
	call &bb5a
	ld a, 10
	call &bb5a
L14:
	ret
printchar:
	pop bc
	pop hl
	push hl
	push bc
	ld a, l
	call &bb5a
L15:
	ret
printdec:
	push bc
	push bc
	dec sp
	ld hl,1
	add hl,sp
	push hl
	ld hl,0
	pop de
	call Lpint
	ld hl,3
	add hl,sp
	push hl
	ld hl,10000
	pop de
	call Lpint
	ld hl,7
	add hl,sp
	call Lgint
	push hl
	ld hl,0
	pop de
	call Llt
	ld a,h
	or l
	jp z,L17
	ld hl,7
	add hl,sp
	push hl
	ld hl,9
	add hl,sp
	call Lgint
	call Lneg
	pop de
	call Lpint
	ld hl,45
	push hl
	call printchar
	pop bc
L17:
L18:
	ld hl,3
	add hl,sp
	call Lgint
	push hl
	ld hl,1
	pop de
	call Lge
	ld a,h
	or l
	jp z,L19
	ld hl,0
	add hl,sp
	push hl
	ld hl,9
	add hl,sp
	call Lgint
	push hl
	ld hl,7
	add hl,sp
	call Lgint
	pop de
	call Ldiv
	push hl
	ld hl,48
	pop de
	add hl,de
	pop de
	call Lpchar
	ld hl,0
	add hl,sp
	call Lgchar
	push hl
	ld hl,48
	pop de
	call Lne
	push hl
	ld hl,5
	add hl,sp
	call Lgint
	push hl
	ld hl,1
	pop de
	call Leq
	pop de
	call Lor
	push hl
	ld hl,3
	add hl,sp
	call Lgint
	pop de
	call Lor
	ld a,h
	or l
	jp z,L20
	ld hl,1
	add hl,sp
	push hl
	ld hl,1
	pop de
	call Lpint
	ld hl,0
	add hl,sp
	call Lgchar
	push hl
	call printchar
	pop bc
L20:
	ld hl,7
	add hl,sp
	push hl
	ld hl,9
	add hl,sp
	call Lgint
	push hl
	ld hl,7
	add hl,sp
	call Lgint
	pop de
	call Ldiv
	ex de,hl
	pop de
	call Lpint
	ld hl,3
	add hl,sp
	push hl
	ld hl,5
	add hl,sp
	call Lgint
	push hl
	ld hl,10
	pop de
	call Ldiv
	pop de
	call Lpint
	jp L18
L19:
L16:
	inc sp
	pop bc
	pop bc
	ret
printhex:
	push bc
	dec sp
	ld hl,1
	add hl,sp
	push hl
	ld hl,16
	pop de
	call Lpint
	ld hl,5
	add hl,sp
	call Lgint
	push hl
	ld hl,0
	pop de
	call Llt
	ld a,h
	or l
	jp z,L22
	ld hl,5
	add hl,sp
	push hl
	ld hl,256
	push hl
	ld hl,9
	add hl,sp
	call Lgint
	pop de
	add hl,de
	pop de
	call Lpint
L22:
L23:
	ld hl,1
	add hl,sp
	call Lgint
	push hl
	ld hl,1
	pop de
	call Lge
	ld a,h
	or l
	jp z,L24
	ld hl,0
	add hl,sp
	push hl
	ld hl,7
	add hl,sp
	call Lgint
	push hl
	ld hl,5
	add hl,sp
	call Lgint
	pop de
	call Ldiv
	push hl
	ld hl,48
	pop de
	add hl,de
	pop de
	call Lpchar
	ld hl,0
	add hl,sp
	call Lgchar
	push hl
	ld hl,57
	pop de
	call Lgt
	ld a,h
	or l
	jp z,L25
	ld hl,0
	add hl,sp
	push hl
	call Lgchar
	push hl
	ld hl,39
	pop de
	add hl,de
	pop de
	call Lpchar
L25:
	ld hl,0
	add hl,sp
	call Lgchar
	push hl
	call printchar
	pop bc
	ld hl,5
	add hl,sp
	push hl
	ld hl,7
	add hl,sp
	call Lgint
	push hl
	ld hl,5
	add hl,sp
	call Lgint
	pop de
	call Ldiv
	ex de,hl
	pop de
	call Lpint
	ld hl,1
	add hl,sp
	push hl
	ld hl,3
	add hl,sp
	call Lgint
	push hl
	ld hl,16
	pop de
	call Ldiv
	pop de
	call Lpint
	jp L23
L24:
L21:
	inc sp
	pop bc
	ret
main:
	call initamsdos
	ld hl,L0+0
	push hl
	call openfile
	pop bc
L27:
	ld hl,1
	ld a,h
	or l
	jp z,L28
	jp L27
L28:
L26:
	ret
openfile:
	push bc
	ld hl,0
	add hl,sp
	push hl
	ld hl,192
	pop de
	call Lpint
	ld hl,4
	add hl,sp
	call Lgint
	push hl
	ld hl,readBuffer
	push hl
	call openread
	pop bc
	pop bc
	push hl
	ld hl,0
	pop de
	call Leq
	ld a,h
	or l
	jp z,L30
	jp L29
L30:
	ld hl,screenBuffer
	push hl
	call getchar
	pop bc
	call closeread
	ld hl,screenBuffer
	push hl
	ld hl,-16384
	push hl
	ld hl,16384
	push hl
	call memcpy
	pop bc
	pop bc
	pop bc
L29:
	pop bc
	ret

; DATA
L0:	db 72,89,80,84,79,49,46,83
	db 67,82,0
readBuffer:
	ds 2048
screenBuffer:
	ds 16384

; CRT
Lpint:
	ld a,l
	ld (de),a
	inc de
	ld a,h
	ld (de),a
	ret

Lgint:
	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	ret

Llt:
Rcrt5:
	call Lcmp
	ret c
	dec hl
	ret

Leq:
Rcrt0:
	call Lcmp
	ret z
	dec hl
	ret

Lne:
Rcrt1:
	call Lcmp
	ret nz
	dec hl
	ret

Lgt:
	ex de,hl
Rcrt2:
	call Lcmp
	ret c
	dec hl
	ret

Lle:
Rcrt3:
	call Lcmp
	ret z
	ret c
	dec hl
	ret

Lge:
Rcrt4:
	call Lcmp
	ret nc
	dec hl
	ret

Luge:
Rcrt6:
	call Lucmp
	ret nc
	dec hl
	ret

Lult:
Rcrt7:
	call Lucmp
	ret c
	dec hl
	ret

Lgchar:
	ld a,(hl)
	ld l,a
	rlca
	sbc a,a
	ld h,a
	ret

Lpchar:
	ld a,l
	ld (de),a
	ret

Lor:
	ld a,l
	or e
	ld l,a
	ld a,h
	or d
	ld h,a
	ret

Land:
	ld a,l
	and e
	ld l,a
	ld a,h
	and d
	ld h,a
	ret

Lcmp:
	ld a,e
	sub l
	ld e,a
	ld a,d
	sbc a,h
	ld hl,1
	jp m,Lcmp1
	or e
	ret
Lcmp1:
	or e
	scf
	ret

Lucmp:
	ld a,d
	cp h
	jr nz,Lucmp1
	ld a,e
	cp l
Lucmp1:
	ld hl,1
	ret
Lasr:
	ex de,hl
Lasr1:
	dec e
	ret m
	ld a,h
	rla
	ld a,h
	rra
	ld h,a
	ld a,l
	rra
	ld l,a
	jr Lasr1
Lasl:
	ex de,hl
Lasl1:
	dec e
	ret m
	add hl,hl
	jr Lasl1
Lsub:
	ld a,e
	sub l
	ld l,a
	ld a,d
	sbc a,h
	ld h,a
	ret
Lneg:
Rcrt10:
	call Lcom
	inc hl
	ret
Lcom:
	ld a,h
	cpl
	ld h,a
	ld a,l
	cpl
	ld l,a
	ret
Llneg:
	ld a,h
	or l
	jr z,Llneg1
	ld hl,0
	ret
Llneg1:
	inc hl
	ret
Lbool:
	ld a,h
	or l
	ret z
	ld hl,1
	ret
Lmul:
	ld b,h
	ld c,l
	ld hl,0
Lmul1:
	ld a,c
	rrca
	jr nc,Lmul2
	add hl,de
Lmul2:
	xor a
	ld a,b
	rra
	ld b,a
	ld a,c
	rra
	ld c,a
	or b
	ret z
	xor a
	ld a,e
	rla
	ld e,a
	ld a,d
	rla
	ld d,a
	or e
	ret z
	jr Lmul1
Lcase:
	ex de,hl
	pop hl
Lcase1:
	call Lcase4
	ld a,e
	cp c
	jr nz,Lcase2
	ld a,d
	cp b
	jr nz,Lcase2
	call Lcase4
	jr z,Lcase3
	ld hl, 0
	add hl,bc
	push hl
	ret
Lcase2:
	call Lcase4
	jr nz,Lcase1
Lcase3:
	dec hl
	dec hl
	dec hl
	ld d,(hl)
	dec hl
ld e,(hl)
	ex de,hl
	jp (hl)
Lcase4:
	ld c,(hl)
	inc hl
	ld b,(hl)
	inc hl
	ld a,c
	or b
	ret
cmde:
	ld a,d
	or a
	ret p
	call ndeneg
	ret
cmbc:
	ld a,b
	or a
	ret p
	call nbcneg
	ret
Ldiv:
	ld b,h
	ld c,l
	ld a,d
	xor b
	push af
	call cmde
	call cmbc
	ld a,16
	push af
	ex de,hl
	ld de,0
ndiv1:
	add hl,hl
nrdel:
	ld a,e
	rla
	ld e,a
	ld a,d
	rla
	ld d,a
	or e
	jr z,ndiv2
ncmpbd:
	ld a,e
	sub c
	ld a,d
	sbc a,b
	jp m,ndiv2
	ld a,l
	or 1
	ld l,a
	ld a,e
	sub c
	ld e,a
	ld a,d
	sbc a,b
	ld d,a
ndiv2:
	pop af
	dec a
	jr z,ndiv3
	push af
	jr ndiv1
ndiv3:
	pop af
	ret p
	call ndeneg
	ex de,hl
	call ndeneg
	ex de,hl
	ret
ndeneg:
	ld a,d
	cpl
	ld d,a
	ld a,e
	cpl
	ld e,a
	inc de
	ret
nbcneg:
	ld a,b
	cpl
	ld b,a
	ld a,c
	cpl
	ld c,a
	inc bc
	ret
l)
	push af
	ld c,7
	ld a,e
	rla
	ld e,a
	ld a,d
	rla
	ld d,a
	or e
	jr z,ndiv2
ncmpbd:
	ld a,e
	sub c
	ld a,d
	sbc a,b
	jp m,ndiv2
	ееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееее