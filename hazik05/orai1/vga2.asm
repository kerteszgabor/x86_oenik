
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov 	cx, 0

	mov		dl, 100
	mov		dh, 100
	push	dx

	mov		ax,	13h  ;switch to 320*200
	int		10h

	mov		ax,	0a000h	; set video starting address into ax temp.
	mov		es, ax			; move into extra segment

Rajz:
	; Pixel in memory = Y * 320 +X
	pop		dx			; take x and y into dx
	xor 	ah, ah
	mov 	al, dh	; Y in ax (coz ah is 0)
	push	dx
	mov 	bx, 320
	mul		bx			; multiply Y by 320, result is 32 bits (16 * 16) --> in AX
	pop 	dx			; dx = DH(y coord), DL(x coord)
	add 	al, dl	; add x coord to 320 * y
	jnc		Pixel
	inc 	ah			; there's carry
	; adding two 8 bits in a 16 bit space
	; idea: add the two 8 bits, if there's carry, manually increase the higher bits

Pixel:
	push	dx
	mov   di, ax
	mov 	al, cl			; pixel color
	inc 	cl
	mov 	es:[di], al	;	specify segment (now es:)
	; write the pixel color to the previously calculated video memory address
	; the VGA displays the pixel instantly

Var:
	xor		ah, ah
	int 	16h

	cmp 	al, 27
	jz		Program_Vege

	cmp 	ah, 75				; cursor keys don't have an ASCII code, only Scan code!
	jz		Balra

	cmp 	ah, 77				; cursor keys don't have an ASCII code, only Scan code!
	jz		Jobbra

	cmp 	ah, 72				; cursor keys don't have an ASCII code, only Scan code!
	jz		Felfele

	cmp 	ah, 80				; cursor keys don't have an ASCII code, only Scan code!
	jz		Lefele

	jmp		Var

Balra:
	pop  	dx
	dec		dl 			; decrement X
	cmp		dl, 1		; has x reached the left boundary?
	jnc		Tarol
	inc 	dl			; if we reached the wall, then move back to last legit coord
	jmp 	Tarol

Jobbra:
		pop  	dx
		inc		dl
		cmp		dl, 250
		jc		Tarol
		dec 	dl
		jmp		Tarol

Felfele:
				pop  	dx
				dec		dh
				cmp		dh, 1
				jnc		Tarol
				inc 	dh
				jmp		Tarol

Lefele:
								pop  	dx
								inc		dh
								cmp		dh, 200
								jc		Tarol
								dec 	dh
Tarol:
	push 	dx
	jmp		Rajz

Program_Vege:
	mov ax, 03h  ; change back video mode upon exit
	int 10h

	pop dx

	mov ax, 4c00h
	int 21h


Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
