
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov di, offset ertek1
	mov si, offset ertek2

MenuBevitel:
				mov	ax, 03h
				mov bh, 0
				int	10h

				mov	ah, 02h
				mov bh, 1
				mov dh, 2
				mov dl, 50
				int 10h

				mov dx, offset ertek1
				mov	ah, 09h
				int	21h

				mov	ah, 02h
				mov dh, 3
				int 10h

				mov dx, offset ertek2
				mov	ah, 09h
				int	21h

				mov	ah, 02h
				mov bh, 0
				mov dh, 10
				mov dl, 0
				int 10h

				mov dx, offset menu1 ;menü - 1
        mov ah,09
        int 21h

        mov ah,02h
        mov bh,0
        mov dh,11
				mov dl,0
        int 10h

        mov dx, offset menu2 ;menü - 2
        mov ah,09
        int 21h

        mov ah,02h
        mov bh,0
        mov dh,12
        mov dl,0
        int 10h

        mov dx, offset menu3 ;menü - ESC
        mov ah,09
        int 21h

				xor	ax, ax
				int	16h
				mov bl, al

				cmp al, "1"
				jz	Bevitel

				cmp al, "2"
				jz 	Bevitel

				cmp al, 27
				jz	Program_Vege_Jumper

				jmp MenuBevitel

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
	jmp Vizsg


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

	cmp bl, "1"
	jz	Tarol1
	jmp	Tarol2

Program_Vege_Jumper:
jmp Program_Vege

Bevitel_Jumper:
jmp Bevitel

Tarol1:
	mov [di], al
	mov al, "$"
	inc	di
	mov [di], al

	mov ah, 02h
	mov	bh, 0
	mov dh, 5
	mov dl, 28
	int 10h

	mov dx, offset ertek1
	mov ah, 09h
	int	21h

	mov ax, offset ertek1
	add ax, 4
	cmp ax, di
	jnz	Bevitel
	jmp	MenuBevitel

	Tarol2:
		mov [si], al
		mov al, "$"
		inc	si
		mov [si], al

		mov ah, 02h
		mov	bh, 0
		mov dh, 5
		mov dl, 28
		int 10h

		mov dx, offset ertek2
		mov ah, 09h
		int	21h

		mov ax, offset ertek2
		add ax, 4
		cmp ax, si
		jnz	Bevitel_Jumper
		jmp	MenuBevitel

Program_Vege:
	mov ax, 4c00h
	int 21h

	menu1:
	        db"1 - Elso szam beirasa$"
	    menu2:
	        db"2 - Masodik szam beirasa$"
	    menu3:
	        db"ESC - Kilepes$"


ertek1:
			db "****$"

ertek2:
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
