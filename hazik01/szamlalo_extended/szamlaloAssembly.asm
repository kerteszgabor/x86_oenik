
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov	ax, 03h
	int	10h

	; Kertész Gábor - T7O47L munkája

Kiir:
	mov	ah, 02h
	mov	bh, 0
	mov	dh, 10
	mov	dl, 0
	int 	10h

	mov	ah, 09h
	mov	dx, offset uzenet1
	int 	21h

	mov	dx, offset szamlalo_l
	int	21h

	mov	dx, offset szamlalo_r
	int	21h

Bevitel:
	xor	ax, ax
	int	16h

	cmp	al, 27
	jz	Program_Vege

	cmp	al, "a"
	jz	IncrementRight
	cmp	al, "d"
	jz	DecrementRight

	jmp	Bevitel

	IncrementLeft:
		mov	di, offset szamlalo_l
		mov	al, [di]

		cmp	al, "9"
		jz	Bevitel

		inc	al
		mov	[di], al
		;set right value to 0
		mov	di, offset szamlalo_r
		mov al, [di]
		mov al, "0"
		mov [di], al

		jmp	Kiir

	DecrementLeft:
		mov	di, offset szamlalo_l
		mov	al, [di]

		cmp	al, "0"
		jz	Bevitel

		dec	al
		mov	[di], al
		;set right value to 9
		mov	di, offset szamlalo_r
		mov al, [di]
		mov al, "9"
		mov [di], al

		jmp	Kiir

	IncrementRight:
		mov	di, offset szamlalo_r
		mov	al, [di]

		cmp	al, "9"
		jz IncrementLeft

		inc	al
		mov	[di], al

		jmp	Kiir

	DecrementRight:
		mov	di, offset szamlalo_r
		mov	al, [di]

		cmp al, "0"
		jz DecrementLeft

		dec	al
		mov	[di], al

		jmp	Kiir

Program_Vege:
	mov ax, 4c00h
	int 21h

uzenet1:
	db	"A szamlalo erteke: $"


	szamlalo_l:
		db	"0$"

	szamlalo_r:
		db	"0$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
