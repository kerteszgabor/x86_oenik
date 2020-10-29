
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov 	BL, 14
	add	BL, 48

	mov	ah, 02
	mov 	DL, BL
	int	21h

Program_Vege:
	mov ax, 4c00h
	int 21h


Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

