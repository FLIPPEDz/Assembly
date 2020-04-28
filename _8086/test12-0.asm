assume cs:code

code segment

start:
	mov ax,cs
	mov ds,ax
	mov si,offset do

	mov ax,0
	mov es,ax
	mov di,200h

	mov cx,offset do0end-offset do
	cld
	rep movsb

	;set int vector
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200h
	mov word ptr es:[0*4+2],0

	mov ax,4c00h
	int 21h

do:
	jmp short do0start
	db "divideerror!"

do0start:
	mov ax,cs
	mov ds,ax
	mov si,202h

	mov ax,0b800h
	mov es,ax
	mov di,12*160+34*2

	mov cx,13

s:
	mov al,[si]
	mov es:[di],al
	inc si
	add di,2
	loop s
	mov ax,4c00h
	int 21h

do0end:	nop
code ends
end start