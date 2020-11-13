;==========================================================================
; Processzorok utasítás szintû kezelése
; Nappali
;
; Név: Kertész Gábor Mihály
; Neptun kód: T7O47L
; Dátum: 2020.11.12
;
;==========================================================================

Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

Feladat_1:
;===========================================================================
; 1. feladat:
;
; Határozza meg a (4^N / 8) függvény értékét, ahol az N egy a billentyûzetrõl
; beolvasott pozitív egész szám, melynek értékei csak az alábbiak lehetnek:
;
; 		1, 2, 3
;
; A leütött billentyût be kell helyettesíteni az N helyére, majd az eredményt
; ki kell írni a kettõspont után!
;
; pl: (4^3 / 8)  = eredmény 8:
; 1. feladat: függvény eredmenye: 8
;
; Nem megengedett karakter esetén írja ki, az alábbit:
;  		"Hibás karakter!"
; (Csak egyszer fusson le)
; Használja a program elõre megírt üzenetét (hibas_karakter)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
Torles:
	mov	ax, 03h
	int	10h

	mov	dx, offset feladat1
	mov	ah,9
	int	21h

	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si
; --------------------------------------------------------------------------
; Ide írja a megfelelõ programrészt!
	int 16h
	mov bx, ax
	mov ax, 4
  mov cx, 3
	mov bh, "1"

Ellenoriz:
	cmp	bl, bh
	jz	Verified
	inc	bh
	loop Ellenoriz

	mov	ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl,	0
	int 10h

	mov dx, offset hibas_karakter
	mov ah, 09h
	int	21h
	xor	ax, ax
	int	16h
	jmp Feladat_2

Verified:
	mov	bh, 0
	mov cx, 1
;Hatvanyoz:
	mul		ax
	;loop 	Hatvanyoz
;	mov 	bx, 8
;  div		bx
	mov 	di, offset eredmeny
	mov		[di], ax


	mov	ah, 02h
	mov bh, 0
	mov dh, 1
	mov dl,	45
	int 10h

	mov dx, [di]
	add	dx, 48
	mov ah, 02h
	int	21h


; Eddig
; --------------------------------------------------------------------------
; Várakozás billentyû leütésre
	xor	ax, ax
	int	16h

Feladat_2:
;===========================================================================
; 2. feladat:
;
; Számolja meg az alábbi mondat szavait és írja ki a  képernyõre:
;
;	"Az assembly nyelv nem keverendo ossze a gepi koddal!"
;
; Feltételezzük, hogy a magyar helyesírási szabályoknak megfelelõen a szavak
; között mindig 1 szóköz van!
; Használja a program elõre megírt üzenetét (mondat)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
	mov	ax, 03h
	int	10h

	mov	ah,9
	mov	dx, offset feladat2
	int	21h

	mov     dh, 2
	mov     dl, 5
	xor     bx, bx
	mov     ah, 02
	int     10h

	mov	ah,9
	mov	dx, offset mondat
	int	21h

	mov     dh, 3
	mov     dl, 5
	xor     bx, bx
	mov     ah, 02
	int     10h

	mov	ah,9
	mov	dx, offset feladat2_1
	int	21h

	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si


; --------------------------------------------------------------------------
; Ide írja a megfelelõ programrészt!
  mov	di, offset mondat
	mov	bx, "0"
	mov cx, "1"
startloop:
	inc cx
	inc di
	mov	al, [di]
	cmp al, 36
	jz	Kiir
	mov	al, [di]
	cmp al, 32
	jz  AddOne
	loop startloop

AddOne:
	inc bx
	jmp startloop

Kiir:
	inc bx
	mov dx, bx
	mov ah, 02h
	int	21h

; Eddig
; --------------------------------------------------------------------------
; Várakozás billentyû leütésre
	xor ax, ax
	int 16h


Feladat_3:
;===========================================================================
; 3. feladat:
; Döntse el a megnyomott bilentyûrõl, hogy számot, vagy egyéb karaktert
; "vitt" be! A ciklusból CSAK AZ "ESC" billentyû leütésével lehet kilépni.
; Használja a program elõre megírt üzeneteit (uzenetszam, uzenetnemszam)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
	mov	ax, 03h
	int	10h

	mov	ah,9
	mov	dx, offset feladat3
	int	21h

	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si

; --------------------------------------------------------------------------
; Ide írja a megfelelõ programrészt!
	push bx
start3:
	pop cx
	mov ax, 03h
	int 10h
	int	16h

	inc 	cx
	cmp 	al, 27
	jz		Vege
	push 	cx
	mov 	cx, 10
	mov ah, "0"
Vizsg:
	cmp al, ah
	jz	KiirTrue
	inc	ah
	loop	Vizsg
	;if false:
	mov dx, offset uzenetnemszam
	mov ah, 09h
	int	21h
	mov	ah, 0h
	int 16h

  loop start3
KiirTrue:
	mov dx, offset uzenetszam
	mov ah, 09h
	int	21h
	mov	ah, 0h
	int 16h
	loop start3

Vege:
; Eddig
; --------------------------------------------------------------------------
; Várakozás billentyû leütésre
	xor ax, ax
	int 16h


	mov ax, 03h
	int 10h

Program_Vege:
	mov	ax, 4c00h
	int	21h


feladat1	db	"1. feladat: (4^N / 8) fuggveny eredmenye: $"
hibas_karakter	db	"Hibas karakter!$"
eredmeny db  "x"


feladat2	db	"2. feladat: Szavak szama az alabbi mondatban:$"
feladat2_1	db	"Szavak szama: $"
mondat		db	"Az assembly nyelv nem keverendo ossze a gepi koddal!$"


feladat3	db	"3. feladat: Szam vagy nem szam: $"
uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy lett leutve!$"


Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
