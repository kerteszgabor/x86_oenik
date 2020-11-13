
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
  push dx

  mov	ah, 0h
  int 16h
	sub ax,49
	mov	bx, ax		;bx tárolja a késleltetést, amit bekérünk az elején

Kiir:
	mov	dx, di
	mov	dh, dl		;sor koordinátát DH-ba másol

	mov	cx, si
  mov dl, cl		;oszlop koordinátát DL-be másol

	xor	bh, bh		;video page nem kell
	mov	ah, 02h
	int	10h

	mov	ah, 02		;string kiírás
	mov	dl, '*'
	int	21h

Kesleltet:
	mov	ah, 01h
	int	16h

	jz	nincsbill
	mov	ah, 00h		;biztosan van valami az input bufferben, kiolvassuk
	int	16h
	cmp	al, 27
	jz	Program_Vege

nincsbill:
	xor	ah, ah
	int	1ah

	pop	cx			;peek to copy last reference time into cx
	push	cx
	push	dx
	sub	dx, cx		;calculate time passed

	mov	al, bl		;bl = késleltetés ideje (mivel 10 karakterre elég 4 bit ezért, bl-ben van az érték)

	cmp	dx, ax
	pop	ax
	jc	Kesleltet

	pop	cx
	push	ax

  cmp si, 79
	jz	Tovabb
	cmp	di, 0
	jz	Jobbra

Tovabb:
	cmp	di, 23
  jz      Tovabb2

	cmp	si, 79
  jz      Lefele

Tovabb2:
  cmp     si, 0
  jz      Tovabb3
	cmp	di,	23
	jz	Balra

Tovabb3:
	cmp	di, 1
  jz      Program_Vege

	cmp	si, 0
	jz	Felfele

Jobbra:
  inc     si
  jmp     Kiir
Lefele:
	inc	di
	jmp	Kiir
Balra:
	dec	si
  jmp     Kiir
Felfele:
  dec     di
	jmp	Kiir

Program_Vege:
	mov	ax, 4c00h
	int	21h



Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
