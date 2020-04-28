assume cs:code

code segment

start:
	mov ax,cs
	mov ds,ax
	mov si,offset capital
	mov ax,0
	mov es,ax
	mov di,200h
	mov cx,offset capitalend-offset capital
	cld
	rep movsb
	
	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0

	mov ax,4c00h
	int 21h

capital:
	push ax
	push cx
	push es
	push di
	
	mov ax,0b800h
	mov es,ax

	mov ax,0
	mov al,160
	mul dh
	mov bx,ax
	mov ax,0
	mov al,2
	mul dl
	add bx,ax

	mov di,bx

	mov ax,0
	mov al,cl
	mov cx,0
s:
	mov cl,ds:[si]
	jcxz rets	 
	mov es:[di],cl
	mov es:[di+1],al
	inc si
	add di,2
	jmp short s	
rets:
	pop di
	pop es
	pop cx
	pop ax
	iret 	

capitalend: nop

code ends

end start