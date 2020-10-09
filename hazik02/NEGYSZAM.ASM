
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov di, offset ertek

	mov	ax, 03h
	int	10h

Bevitel:
	xor	ax, ax
	int	16h

	mov bx, ax
	mov ax, 03h
	int 10h
	mov ax, bx

	cmp al, 27
	jz	Program_Vege

	mov cx, 10
	mov ah, "0"

Vizsg:
	cmp al, ah
	jz	Tarol
	inc	ah
	loop	Vizsg

	mov	ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl,	0
	int 10h

	mov dx, offset hiba
	mov ah, 09h
	int	21h

	jmp Bevitel

Tarol:

	mov [di], al
	mov al, "$"
	inc	di
	mov [di], al

	mov ah, 02h
	mov	bh, 0
	mov dh, 5
	mov dl, 28
	int 10h

	mov dx, offset ertek
	mov ah, 09h
	int	21h

	mov ax, offset ertek
	add ax, 4
	cmp ax, di
	jnz	Bevitel

	mov	ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 0
	int 10h

	mov dx, offset uzenet
	mov	ah, 09h
	int	21h


Program_Vege:
	mov ax, 4c00h
	int 21h

ertek:
			db "****$"
hiba:
			db "Nem megengedett karakter!$"
uzenet:
			db "Vege a bevitelnek$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
