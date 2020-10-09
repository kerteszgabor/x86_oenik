
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX
	
	mov	ax, 03h
	int	10h

Kiir:
	mov	ah, 02h
	mov	bh, 0
	mov	dh, 10
	mov	dl, 0
	int 	10h

	mov	ah, 09h
	mov	dx, offset uzenet1
	int 	21h
	
	mov	dx, offset szamlalo
	int	21h

	mov	dx, offset uzenet2
	int 	21h

Bevitel:
	xor	ax, ax
	int	16h

	cmp	al, 27
	jz	Program_Vege

	cmp	al, "a"
	jz	Szamol
	jmp	Bevitel

Szamol:
	mov	di, offset szamlalo
	mov	al, [di]

	cmp	al, "9"			;ha már 9
	jz	Program_Vege

	inc	al
	mov	[di], al

	jmp	Kiir

Program_Vege:
	mov ax, 4c00h
	int 21h

uzenet1:
	db	"Az a billentyű $ "

uzenet2:
	db	" alkalommal volt leütve.$"

szamlalo:
	db	"0$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

