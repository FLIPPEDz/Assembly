assume	cs:code,ds:data,ss:stack

data segment
	db 'welcome to masm!'
	db 2,24h,71h
data ends

stack segment
	db 16 dup(0) 
stack ends

code segment

start:	
	mov ax,stack 
	mov ss,ax
	mov sp,16
	
	mov ax,data
	mov ds,ax

	mov cx,3
	mov ax,0b800h
	mov es,ax

	mov si,10h
	mov ax,0
s:
	mov ah,ds:[si]
	push cx
	push si
	mov cx,16
	mov si,0
	add si,10*160+64
	mov bx,0
	mov di,1
	add di,10*160+64

s1:
	mov al,[bx]
	mov es:[bx+si],al
	mov es:[bx+di],ah
	inc bx
	inc si
	inc di
	loop s1

	pop si
	inc si
	pop cx
	mov dx,es
	add dx,0ah
	mov es,dx

	loop s	

	mov ax,4c00h
	int 21h

code ends

end start