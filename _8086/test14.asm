assume cs:codesg,ds:data
data segment
  d1 db 9,8,7,4,2,0
  d2 db 12 dup (0)
  d3 db '00/00/00 00:00:00','$'
data ends
codesg segment
start:
  mov ax,data
  mov ds,ax
  mov bp,offset d1
  mov si,offset d2
  mov di,offset d3

;���ζ�ȡʱ������д��d2��
  mov cx,6
s:
  mov al,ds:[bp]
  out 70h,al
  in al,71h
  mov bl,al   ;�ݴ�al
  push cx     ;����ѭ������
  mov cl,4
  shr al,cl   ;�õ�ʮλ
  add al,30h
  and bl,00001111B   ;�õ���λ
  add bl,30h
  mov ds:[si],al
  inc si
  mov ds:[si],bl
  inc bp
  inc si
  pop cx
  loop s

;��d2������д��d3�Σ���d3�ζ�Ӧ�ַ�Ϊ'0'ʱ��д��
  mov si,offset d2    ;����
  mov cx,17           ;d3�γ���Ϊѭ������
s1:
  mov al,ds:[di]
  cmp al,30h
  jnz next
  mov al,ds:[si]
  mov ds:[di],al
  inc si
next:
  inc di
  loop s1

;����10h�ж��ù��λ��
  mov ah,2
  mov bh,0
  mov dh,10
  mov dl,20
  int 10h

;����21h�ж���ʾ�ַ���
  mov dx,offset d3
  mov ah,9
  int 21h

  mov ax,4c00h
  int 21h

codesg ends
end start