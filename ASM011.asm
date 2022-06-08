TITLE ASM011     (ASM011.asm)

INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data


.code
ChessBoard proc uses ebp
	mov ebp, esp
	sub esp, 2
	mov BYTE PTR [ebp-1], 0 ;black
	mov BYTE PTR [ebp-2], 15 ;white
	xor edx, edx
	mov ecx, 16
	call Gotoxy
	call PrintBoard 
	mov esp, ebp
	call WaitMsg
	ret
ChessBoard endp

PrintBoard proc uses ecx edx
	mov ecx, 8
	L1:
		call ColorSwap
		call PrintBlocks
		add dh, 4
		call Gotoxy
		sub ecx, 1
		jnz L1
	ret
	PrintBoard endp

PrintBlocks proc uses ecx edx
	mov ecx, 8
	L2:
		call PrintBlock
		
		add dl, 8		
		call Gotoxy
		call ColorSwap	
		sub ecx, 1
		jnz L2
	ret
PrintBlocks endp

PrintBlock proc USES ecx edx
	mov ecx, 4
	L3:
		call printLine		
		add dh, 1			
		call Gotoxy
		sub ecx, 1
		jnz L3
	ret
PrintBlock endp

printLine proc uses eax ecx
	mov ecx, 8
	mov eax, 219
	L4:
		call WriteChar	
		sub ecx, 1
		jnz L4
	ret
printLine endp

ColorSwap proc uses eax ebx
	mov al, BYTE PTR [ebp-1]
	mov ah, BYTE PTR [ebp-2]
	mov BYTE PTR[ebp - 1], ah
	mov BYTE PTR[ebp - 2], al
	movzx eax, ah
	call SetTextColor
	ret
ColorSwap endp

RecursiveAddition proc
	cmp eax, 10
	je jump2
	jump1:
		inc eax
		call RecursiveAddition
	jump2:
	ret
RecursiveAddition endp
	

main PROC
	call ChessBoard
	mov eax, 0
	call RecursiveAddition

	exit
main ENDP
END main