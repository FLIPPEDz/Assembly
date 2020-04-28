assume	cs:code,ds:data

data segment
	db 'Welcome to masm!',0
data ends

code segment

start:	
	mov dh,8
	mov dl,3
	mov cl,2      ;бли╚	
	mov ax,data 
	mov ds,ax
	mov si,0
	call show_str

	mov ax,4c00h
	int 21h

show_str:
	push ax
	push bx
	push cx
	push dx
	push es
	push di
	push si


	mov ax,0b800h
	mov es,ax	
	sub ax,ax

	mov al,160
	mov ah,0
	mul dh
	sub dh,dh 	
	add dl,dl
	add ax,dx
	mov di,ax
	
	mov al,cl
	sub cx,cx

next:
	mov cl,[si]
	jcxz rets
	mov es:[di],cl
	mov es:[di+1],al
	inc si
	add di,2
	jmp short next
		
rets:
	pop si
	pop di
	pop es
	pop dx
	pop cx
	pop bx
	pop ax
	ret

code ends

end start