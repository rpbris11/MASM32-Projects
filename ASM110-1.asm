
; Ryan Brisbane
; Last update: April 8, 2021 at 2:59 am
; This program contains two recursive procedures - 
; one that prints the factorial of a given number, and one that reverses a given string and prints it

INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
source BYTE "test string",0

.code

; this is the procedure implemented in 8.3.2 in the textbook. it returns the factorial of a number, pushed to the stack prior to calling
Factorial proc
	push ebp
	mov ebp, esp
	mov eax, [ebp+8] ;get n
	cmp eax, 0 ; n>0?
	ja L1 ;yes - continue
	mov eax, 1 ;no - return 1 as the value of 0!
	jmp L2 ;return to the caller

	L1:
		dec eax
		push eax ;Factorial(n-1)
		call Factorial
	ReturnFact:
		mov ebx, [ebp+8] ;get n
		mul ebx ;EDX:EAX = EAX*EBX
	L2:
		pop ebp ;return eax
		ret 4 ;clean up stack
Factorial endp

;This procedure takes the existing string, source, and prints it to the console, letter by letter, in reverse
ReverseString proc
	push ebp
	mov ebp, esp
	cmp ecx, 0 ;base case: if we've reached the beginning of the string, the iteration is completed
	je L2

	mov al, BYTE PTR [esi+(ecx-1)] ;moves the character at the end (ecx-1 because it would start at the null pointer) into eax
	call WriteChar ;prints the character in eax to the console
	dec ecx
	call ReverseString ;recursive call
	
	L2:
	pop ebp
	ret 
		
ReverseString endp

main PROC

	push 5
	call Factorial
	call WriteDec
	call Crlf

	mov esi, OFFSET source
	mov ecx, LENGTHOF source
	call ReverseString


	exit
main ENDP
END main