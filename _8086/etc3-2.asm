assume	cs:code

code segment

start:

s:
	db 100 dup (0b8h,0,0)
	jmp s
	jmp near ptr s	
	jmp far ptr s

code ends

end start