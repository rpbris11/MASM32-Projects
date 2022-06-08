.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

;question 1
.data
A_value BYTE 10h,20h,30h
B_value SBYTE 10h
C_value WORD 22h
D_value SWORD 5h
E_value DWORD 12h
F_value SDWORD 6h
G_value REAL4 1.2

mov al, A_value
mov bh, B_value
mov ax, C_value
mov dx, D_value
mov esi, E_value
mov edx, F_value
fld G_value ; throws exception here???? what do????????

;question 2
array dword 1,2,3,4,5,6,7,8
.code
main proc
mov esi, OFFSET array
mov ecx, LENGTHOF array -1

loopstart:
	MOV eax,[esi]
	XCHG eax,[esi+3]
	MOV [esi],eax

	add esi, TYPE array
	add esi, TYPE array

	loop loopstart

;question 3
var1 DWORD 12345678h

;question 4

mov ax, 0
mov bx, 0

mov ax, WORD PTR var1 ;move 5678h to ax
mov bx, WORD PTR [var1+2] ;move 1234h to bx
mov WORD PTR var1, bx ;move bx (1234h) to lower part of three: throws error here too!!!
mov WORD PTR [var1+2], ax ;move ax (5678h) to upper part of three

;question 5
intarray DWORD 10000h,20000h,30000h,40000h

mov edi, OFFSET intarray
mov ecx, LENGTHOF intarray ;how to 
mov eax, 0
L1:
	add eax, [edi]
	add edi, TYPE intarray
	loop L1

;question 6
str1 BYTE "Sarah Elizabeth Bailey",0

;question 7
str2 BYTE 20 DUP(0)
mov ecx, LENGTHOF str1
mov esi, 0

L2:
	movzx eax, str2[esi]
	push eax
	inc esi
	loop L2

L3:
	pop eax
	mov str2[esi], al
	inc esi
	loop L3

invoke ExitProcess,0
main endp
end main