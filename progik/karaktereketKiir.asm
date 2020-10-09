
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov	ah, 02h
	mov	dl, "H"
	int	21h


	mov	dl, "e"
	int	21h

	mov	dl, "l"
	int	21h

	int	21h

	mov	dl, "o"
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

