
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov		di, 82h
	; PSP 256 bytes reserved before the code,
	; @80h -->	length of the parameter
	; @81h --> always an escape character
	; @82h --> the actual parameter starting point

	mov		cx, 10 ; set loop var
Keres:												  ;we search for the '/'
	mov		dl, [di]	; index what is @ 82h and compare if it is '/'
	cmp		dl, "/"
	jz 		ParamKezdet
	inc 	di
	loop 	Keres
	jmp		Default 	; if there was no parameters

ParamKezdet:

	inc 	di			; jump to actual number
	mov		bl, [di]
	cmp   bl, "?"
	jz		Helper
	cmp   bl, 58
	jnc		Error_jumper
	sub		bl, 48

	inc 	di				; read second number
	mov		bh, [di]
	cmp   bh, 58
	jnc		Error_jumper
	cmp 	bh, 48
	jc		OneDigit
	sub		bh, 48

	; multiply first number by 10 (because it is the second decimal place), and store in al
	mov		ax, 10		; al stores 10, ah is xxxx
	mul   bl				; ax = al * bl

	add		al, bh		; add tens and ones
	mov		cx, ax		; set v0 parameter (ax contains the parameter)
	jmp 	Init

OneDigit:
	mov		cl, bl

	jmp 	Init

Default:
	mov	cx, 10 			; default v0

Init:
	mov	ax, Code
	mov	DS, AX

	xor		di, di		; ball row position
	xor		si, si		; ball column position

	xor		dx, dx
	push	dx				; save time in stack (now: 0)

Torles:
	mov		ax, 03h
	int 	10h

Rajzol:
	mov		bx, di		; temporary register for parsing 16 to 8 bits
	mov		dh, bl		; lower byte of di --> row coordinate
	mov		bx, si
	mov		dl, bl
	xor		bh, bh		; video page = 0
	mov		ah, 02h
	int 	10h

	mov		dx, offset Labda
	mov		ah, 09h
	int 	21h

	pop		ax				; copy time from stack
	push	ax

	mul		al				; multiplication: ax = al * parameter (so al in this case) --> al on second power
	shr		ax, 1			; shift one right --> division by 2

	mov		di, ax

	; calculate Sx

	pop		ax				; take last time
	inc		ax				;	step forward the time
	push	ax				;	save new time
	dec		ax				; recalculate current time

	mul 	cl				; calculate new column position (ax = al * cl)

	mov		si, ax		; save new position

	cmp 	si, 80
	jnc		Program_Vege

	cmp		di, 25
	jnc		Program_Vege

	jmp		Rajzol

Error_jumper:
	jmp Error

Helper:
	mov	ax, Code
	mov	DS, AX
	mov		ax, 03h
	int 	10h
	mov		dh, 10
	mov		dl, 0
	xor 	bh, bh
	mov		ah, 02h
	int   10h

	mov 	dx, offset Helper_text
	mov		ah, 09h
	int 	21h

	mov		dh, 11
	mov		dl, 0
	mov		ah, 02h
	int   10h

	mov 	dx, offset Helper_text2
	mov		ah, 09h
	int 	21h
	jmp Program_Vege

Error:
	mov	ax, Code
	mov	DS, AX
	mov		ax, 03h
	int 	10h

	mov		dh, 10
	mov		dl, 0
	xor 	bh, bh
	mov		ah, 02h
	int   10h

	mov 	dx, offset Error_text
	mov		ah, 09h
	int 	21h

	mov 	ah,	86h
	mov		cx, 60
	int 	15h

	jmp   Default

Program_Vege:
	xor ax, ax
	int 16h
	pop cx
	mov ax, 4c00h
	int 21h

Labda:	db	"0$"
Helper_text: 	db	"A program helyes hasznalatahoz add meg a kovetkezo formaban a parametereket: $"
Helper_text2: 	db	"program.exe /[golyo sebessege (00-99)]$"
Error_text: 	db	"Hiba! Rossz paramterek. Alapertelmezett ertekekkel inditas. (Varj)$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
