
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov	ax, 03h
	int	10h
	
	xor	di, di
	mov	di, 0	
	xor	si, si
	mov	si, 0	
	
	xor	dx, dx
        push    dx      
	push	dx		
	
Kesleltet:
	mov	ah, 01h
	int	16h
	jz	nincsbill
	
	mov	ah, 00h
	int	16h
        cmp     al, 27
	jnz	nincsbill
	jmp	Program_Vege
	
nincsbill:
	xor	ah, ah
	int	1ah
	
	pop	bx
	
	pop	cx
	push	cx
	mov	ax, dx
	sub	dx, cx
	push	ax
	
	mov	al, 10

	xor	ah, ah
        cmp     dx, ax
	
        pop     ax
	
        jc      Vizszintes

	pop	cx
	push	ax
	push	bx

        cmp     di, 23
	jz	Kesleltet
	
	mov	ah, 02h
	mov	bh, 0
	mov	dx, di
	mov	dh, dl
	mov	dl, 79
	int	10h
	
	mov	ah, 02
	mov	dl, '*'
        int     21h
	
	mov	ah, 02h
	xor	bx, bx
        mov     bl, 23
        sub     bx, di
        mov     dh, bl 
	mov	bh, 0
	mov	dl, 0
	int	10h
	
	mov	ah, 02
	mov	dl, '*'
        int     21h
	
        inc     di
	
	pop	bx
	
Vizszintes:
	mov	dx, ax
	sub	dx, bx
	push	ax
	
	mov	al, 4
	
	xor	ah, ah
	cmp	dx, ax
	
	pop	ax
	push	bx
	
	jc	Kesleltet
	
        pop     bx
	push	ax

	cmp	si, 80
	jz	Kesleltet

	mov	ah, 02h
	mov	bh, 0
	mov	dx, si
	mov	dh, 0
	int	10h
	
	mov	ah, 02
	mov	dl, '*'
        int     21h
	
	mov	ah, 02h
	mov	dh, 23
	xor	bx, bx
        mov     bl, 79
        sub     bx, si
        mov     dl, bl
	mov	bh, 0
	int	10h
	
	mov	ah, 02
	mov	dl, '*'
        int     21h
	
        inc     si
        jmp     Kesleltet
	
Program_Vege:
	pop	cx
	mov	ax, 4c00h
	int	21h



Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

