assume	cs:code

code segment

start:

s:
	jmp s
	jmp short s
	jmp near ptr s	
	jmp far ptr s

code ends

end start