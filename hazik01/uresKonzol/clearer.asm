
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov	ah, 09h
	mov	dx, offset clear_text
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int	21h

	mov	ah, 09h
	int 	21h
	
	mov	ah, 09h
	mov	dx, offset clear_text
	int	21h

	mov	ah, 09h
	mov	dx, offset uzenet
	int	21h
	
	

Program_Vege:
	mov ax, 4c00h
	int 21h

clear_text:
	db	"                                                                    $"

uzenet:	
	db	"				Hello gorgeous, you're OEsome.$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

