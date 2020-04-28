assume	cs:code,ds:data

data segment
	dw 16 dup(0)
data ends

code segment

start:	
	mov ax,4240H
	mov dx,000FH
	mov cx,0AH
	mov bx,data
	mov ds,bx
	call divdw
	mov ax,ds:[0]
	mov dx,ds:[2]
	mov cx,ds:[4]

	mov ax,4c00h
	int 21h


divdw:
	push ds
	push dx
	push cx
	push ax
	
	mov ax,dx
	mov dx,0	
	div cx
	
	push dx
	mov ax,dx
	mov ax,0

	mov ds:[0],ax
	mov ds:[2],dx

	pop dx
	pop ax
	push ax

	div cx
	
	mov ds:[0],ax
	mov ds:[4],dx

	pop ax
	pop cx
	pop dx
	pop ds
	ret

code ends

end start