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

;依次读取时间数据写入d2段
  mov cx,6
s:
  mov al,ds:[bp]
  out 70h,al
  in al,71h
  mov bl,al   ;暂存al
  push cx     ;保护循环次数
  mov cl,4
  shr al,cl   ;得到十位
  add al,30h
  and bl,00001111B   ;得到个位
  add bl,30h
  mov ds:[si],al
  inc si
  mov ds:[si],bl
  inc bp
  inc si
  pop cx
  loop s

;将d2段数据写入d3段，当d3段对应字符为'0'时候写入
  mov si,offset d2    ;重置
  mov cx,17           ;d3段长度为循环次数
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

;调用10h中断置光标位置
  mov ah,2
  mov bh,0
  mov dh,10
  mov dl,20
  int 10h

;调用21h中断显示字符串
  mov dx,offset d3
  mov ah,9
  int 21h

  mov ax,4c00h
  int 21h

codesg ends
end start