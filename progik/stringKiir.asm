
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov	ah, 09
	mov	dx, offset uzenet
	int	21h


Program_Vege:
	mov ax, 4c00h
	int 21h

uzenet:	db "ez egy uzenet$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

