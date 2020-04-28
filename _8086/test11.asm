assume	cs:code,ds:data

data segment
	db "Beginner's All-purpose Symbolic Instrction Code.",0
data ends

code segment

start:
	mov ax,data
	mov ds,ax
	mov si,0
	call letterc

	mov ax,4c00h
	int 21h

letterc:
	push ax
	push ds
	push si
	
	mov ax,0
	mov cx,0

s:	
	mov cl,ds:[si]
	jcxz rets
	cmp cl,97
	jb s0
	cmp cl,122
	ja s0
	and cl,11011111b
	mov ds:[si],cl
s0:	inc si
	loop s
rets:
	pop si
	pop ds
	pop ax
	ret

code ends

end start