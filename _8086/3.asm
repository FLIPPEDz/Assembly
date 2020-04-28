assume cs:code
code segment

	mov ax,offfh
	mov ds,ax
	mov bx,0
	
	mov dx,0
	
	mov cs,12
	
s:
	mov al,[bx]
	mov ah,0
	add dx,ax
	inc bx
	loop s

	mov ax,4c00h
	int 21h

code ends
end