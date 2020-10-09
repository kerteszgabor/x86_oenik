
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov di, offset ertek1
	mov si, offset ertek2
	
	mov	ax, 03
	int	10h	
Menu:
	mov	ax, 03h
	mov bh, 0
	int	10h
	
	mov ah,02h
	mov bh,2
	mov dh,5
	mov dl,60
	int 10h

	mov dx, offset ertek1
	mov	ah, 09h
	int	21h

	mov ah,02h
	mov bh,1
	mov dh,5
	mov dl,50
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
	
	xor ax,ax ;al-be mentjük a leütöttet menübe
	int 16h ;billentyű leütése
	
	mov bx,ax
	mov ax, 03
	int 10h
	mov ax,bx
	
	mov bl,al
	
	cmp al,27 
	jz Jump_Program_Vege
	
	cmp al,"1"
	jz Bevitel1mod
	
	cmp al,"2"
	jz Bevitel2mod
	jnz Menu
	

Bevitel1mod:
	mov di, offset ertek1
	jmp Bevitel1
Bevitel2mod:
	mov di,offset ertek2
	jmp Bevitel2
Bevitel1:
	xor ax,ax 
	int 16h 
	
	mov bx,ax
	mov ax,03
	int 10h
	mov ax,bx
	
	cmp al, 27
	jz Jump_Program_Vege
	
	mov cx, 10 
	mov ah, "0" 
	jmp Vizsg1
Bevitel2:
	xor ax,ax 
	int 16h 
	
	mov bx,ax
	mov ax,03
	int 10h
	mov ax,bx
	
	cmp al, 27
	jz Jump_Program_Vege
	
	mov cx, 10 ;cx regiszter 10 ig megy a ciklus
	mov ah, "0" ;cilus 0-9ig? 0 a kezdő
	jmp Vizsg2
Vizsg1: ;cilus 0-9ig?		
	cmp al,ah ; a bemenetet vizsgáljuk hogy egyenlő i-vel?
	jz Tarol1; ha igaz akkor tárol
	inc ah ;ha nem igat, "i"-t növeljük
	loop Vizsg1
	
	mov ah,02h ;kurzor pozícionálás , ah-n dolgozunk.
	mov bh,0
	mov dh,10
	mov dl,0
	int 10h
	
	mov dx, offset hiba ;hiba kiírása
	mov ah,09
	int 21h
	
	jmp Bevitel1
Jump_Program_Vege:
	jmp Program_Vege
Vizsg2: ;cilus 0-9ig?		
	cmp al,ah ; a bemenetet vizsgáljuk hogy egyenlő i-vel?
	jz Tarol2; ha igaz akkor tárol
	inc ah ;ha nem igat, "i"-t növeljük
	loop Vizsg2
	
	mov ah,02h ;kurzor pozícionálás , ah-n dolgozunk.
	mov bh,0
	mov dh,10
	mov dl,0
	int 10h
	
	mov dx, offset hiba ;hiba kiírása
	mov ah,09
	int 21h
	
	jmp Bevitel2

JumpBevitel1:
	jmp Bevitel1
JumpBevitel2:
	jmp Bevitel2

Jump1:
	jmp Menu


	

	
Tarol1:
	mov [di],al 
	inc di 
	mov al, "$" 
	mov [di],al
	
	mov ah,02h
	mov bh,0
	mov dh,5
	mov dl,28
	int 10h
	
	mov dx, offset ertek1
	mov ah,09
	int 21h
	
	mov ax,offset ertek1 ;szám hosszának ellenőrzése
	add ax,4
	
	cmp ax,di
	jnz JumpBevitel1
	
	mov ah,02h
	mov bh,0
	mov dh,7
	mov dl,0
	int 10h
	
	mov dx,offset ertek1
	mov ah,09h
	int 21h
	
	mov ax, offset ertek2
	cmp ax, di
	jz Program_Vege
	jnz Jump1
	
JumpMenu:
	jmp Menu
	
Tarol2:
	mov [si],al 
	inc si 
	mov al, "$"  
	mov [si],al
	
	mov ah,02h
	mov bh,0
	mov dh,5
	mov dl,28
	int 10h
	
	mov dx, offset ertek2
	mov ah,09
	int 21h
	
	mov ax,offset ertek2 ;szám hosszának ellenőrzése
	add ax,4
	cmp ax,si
	jnz JumpBevitel2
	
	mov ah,02h
	mov bh,0
	mov dh,7
	mov dl,0
	int 10h
	
	mov dx,offset ertek2
	mov ah,09h
	int 21h
	
	mov ax, offset ertek1
	cmp ax, di
	jz Program_Vege
	jnz JumpMenu

Program_Vege:
	mov ax, 4c00h
	int 21h

ertek1:
	db"****$"
	
ertek2:
	db"****$"

hiba:
	db"Nem megengedett karakter!$"
	
uzenet:
	db"Vege a bevitelnek!$"
	
menu1:
	db"1 - Elso szam beirasa$"
	
menu2:
	db"2 - Masodik szam beirasa$"
	
menu3:
	db"ESC - Kilepes$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
