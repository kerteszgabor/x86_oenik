
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov	ax, 03h
	int	10h			;képernyő törlése

	xor	di, di
	mov	di, 0
	xor	si, si
	mov	si, 0

	xor	dx, dx
  push dx			;store 1st reference time

  mov	ah, 0h
  int 16h
	sub ax,49
	mov	bx, ax		;bx tárolja a késleltetést, amit bekérünk az elején

Kiir_oszlopok:
	mov cx, 3

	loopstart:
	mov	dh, 0		;sor koordinátát DH-ba másol

	mov	dx, si
  mov dl, dl		;oszlop koordinátát DL-be másol

	xor	bh, bh		;video page nem kell
	mov	ah, 02h
	int	10h

	mov	dl, '*'
	int	21h

	mov	dx, si
  mov dl, dl		;oszlop koordinátát DL-be másol
	mov dh, 23
	int 10h

	mov	dl, '*'
	int 21h
	inc si

	cmp si, 79
	jz 	Program_Vege

	loop loopstart

Kiir_sorok:
	cmp di, 23
	jz Kesleltet

	mov	dx, di
	mov dh, dl		;sor koordináta
	mov	dl, 0

	xor	bh, bh		;video page nem kell
	mov	ah, 02h
	int	10h

	mov	dl, '*'
	int	21h

	mov	dl, 79
	int	10h
	mov	dl, '*'
	int 21h
	inc di

Kesleltet:
	mov	ah, 01h		;async char reading
	int	16h

	jz	nincsbill
	mov	ah, 00h		;biztosan van valami az input bufferben, kiolvassuk
	int	16h
	cmp	al, 27
	jz	Program_Vege

nincsbill:
	xor	ah, ah		;we need ah --> 00h
	int	1ah				;read system timer into CX:DX

	pop	cx				;peek to copy last reference time into cx
	push	cx
	push	dx			;store new reference time
	sub	dx, cx		;calculate time passed, store result in dx

	mov	al, bl		;bl = késleltetés ideje (mivel 10 karakterre elég 4 bit ezért, bl-ben van az érték)

	cmp	dx, ax		;have enough time passed?
	pop	ax				;stack top --> default time
	jc	Kesleltet	;not

	pop	cx				;stack top --> empty
	push	ax			;stack top --> new reference time

	jmp Kiir_oszlopok

Program_Vege:
	mov	ax, 4c00h
	int	21h

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
