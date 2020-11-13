
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Szorzo = 10000
 ; numeric formula for pi calcualation: 1 - 1/3 + 1/5 - 1/7 + 1/9 - ...
Start:
	mov	ax, Code
	mov	DS, AX

	mov		di, offset Eredmeny
	mov		ax, Szorzo
	mov		[di], ax				; first element of the series (multiplied by 10000 of course)

	mov 	cx, 2500
	mov 	si,	3		; denominator of the second element of the series

Szamol:
	mov			ax, Szorzo
	xor			dx, dx
	div			si
	sub			[di], ax
	add			si, 2

	mov			ax, Szorzo
	xor			dx, dx
	div			si
	add			[di], ax
	add			si, 2

	loop		Szamol

; result: [di] * 4
	mov			ax, [di]
	mov			cl, 2
	shl			ax, cl

; tenthousands:
	xor			dx, dx
	mov			bx, 10000
	div			bx					; number of tenthousands in AX, remainder in DX
	push 		dx

	call 		Kiir

;	write decimal point:
	mov			al, "."
	sub			al, 48
	call 		Kiir

; thousands:
	pop			ax
	xor			dx, dx
	mov			bx, 1000
	div			bx
	push 		dx

	call Kiir

	; hundreds:
		pop			ax
		xor			dx, dx
		mov			bx, 100
		div			bx
		push 		dx

		call Kiir

		; tens:
			pop			ax
			xor			dx, dx
			mov			bx, 10
			div			bx
			push 		dx

			call Kiir

			; ones:
				pop			ax

				call Kiir

Program_Vege:
	mov ax, 4c00h
	int 21h

Kiir:
	mov	dl,		al
	add	dl, 	48
	mov	ah,		02h
	int 			21h
	ret

Eredmeny: db "xx"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
