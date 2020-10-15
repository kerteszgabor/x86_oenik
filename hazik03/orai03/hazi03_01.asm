
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	xor 	di, di 	;position of ball
	mov		si, 1		;vector of ball's direction (+1 --> downward; -1 --> upwards)
	xor		dx, dx
	push	dx

	mov		ax, 03h
	int		10h

Torles:

	mov		dx, di	;di is a 16 bit register, so we have to use dx as a temp to move it into an 8 bit
	mov		dh,	dl	;here we go for the low 8 bits (remember: dh is the row number)
	mov		dl, 40  ;column number
	xor		bh,	bh
	mov		ah, 02h
	int		10h

	mov		dx, offset Labda	;write the character on screen
	mov		ah, 09h
	int		21h

Kesleltet:
	;mov		ah, 00h
	;int		16h				;this is the blocking, synchronous solution

	;cmp		al, 27
	;jz		Program_Vege

	;cmp		di, 0
	;jz 		Lefele

	;cmp		di, 24
;	jz 		Felfele

	mov		ah, 01h
	int   16h

	jz		nincsbill	;if z flag is active --> no char in keyboard buffer
	mov		ah, 00h 	;sync character reading
	cmp		al, 27		;at this point, we are sure there's a char in the buffer
	jz		Program_Vege

nincsbill:
	xor		ah, ah
	int		1ah			;reads the current clock time into CX:DX registers
								;note: DX register is more than enough to watch

	pop		cx			;previous time of tick
	push	cx			;peek into the top of the stack (it stays in cx)
	mov 	ax, dx	;current time saved into ax
	sub		dx, cx	;calculate time passed, put result in dx
	push	ax			;save current time

	cmp		di, 5		;di stores the position of the ball
	jnc		Ido1		;not carry --> if the result is same or smaller than 5 (-4..0)
	mov		al, 16	;speed of refresh we would like
	jmp		Beallit	;we found the correct segment of time

Ido1:
	cmp		di, 10		;di stores the position of the ball
	jnc		Ido2		;not carry --> if the result is same or smaller than 10
	mov		al, 8
	jmp		Beallit	;we found the correct segment of time

Ido2:
	cmp		di, 15		;di stores the position of the ball
	jnc		Ido3		;not carry --> if the result is same or smaller than 15
	mov		al, 4
	jmp		Beallit	;we found the correct segment of time

Ido3:
	cmp		di, 20		;di stores the position of the ball
	jnc		Ido4		;not carry --> if the result is same or smaller than 20
	mov		al, 2
	jmp		Beallit	;we found the correct segment of time

Ido4:
	mov 	al, 1

Beallit:
	xor		ah, ah	;al stores the deltaT, so we null ah to have the delta in a 16 bit space
	cmp		dx, ax  ;dx --> elapsed time. if it's smaller than deltaT, we start again

	pop		ax			;actulize last timestamp

	jc		Kesleltet ;if no carry --> deltaT _has_ elapsed, time to redraw the ball

	pop		cx	;we take the old timestamp from the Stack
	push	ax	;save the timestamp of current time as the new reference timestamp

	cmp		di, 0
	jz 		Lefele

	cmp		di, 24
  jz 		Felfele

Mozgas:
	mov 	ah, 02h
	mov 	bh, 0
	mov   cx, dx
	mov   dx, di
	mov 	dh, dl
	mov		dl,	40
	int		10h

	mov 	dx, cx

	mov 	dx, offset Space
	mov   ah, 09h
	int 	21h

	add		di, si ;new position of the ball
	jmp		Torles

Lefele:
	mov		si, 1
	jmp		Mozgas

Felfele:
	mov		si, -1
	jmp		Mozgas

Program_Vege:
	pop	cx
	mov ax, 4c00h
	int 21h

Labda:	db	"o$"	;represents the ball onscreen
Space: 	db  " $"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
