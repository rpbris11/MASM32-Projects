
INCLUDE Irvine32.inc

.386
.stack 4096
ExitProcess PROTO,dwExitCode:DWORD

;question 0
strLen=10
.data
arr BYTE strLen DUP(?)
varA BYTE 61h
varB BYTE 62h
varC BYTE 63h

.code

main proc
call Clrscr
mov esi, offset arr
mov ecx, 20
L4:
	call RandomColor
	call GenerateRandomString
loop L4
call WaitMsg

exit
main endp

GenerateRandomString proc USES ecx
	mov ecx, lengthOf arr
	L3:
		mov eax, 26
		call RandomRange
		add eax, 65
		mov [esi], eax
		call WriteChar
	loop L3
	call Crlf
	ret
GenerateRandomString endp

RandomColor proc
	push eax
	mov eax, 16
	call RandomRange
	call SetTextColor
	ret
RandomColor endp

;question 1 - the parameters should be stored in ebx and ecx. bx/ebx are the outer loop, cx/ecx are the inner loop
nestedLoops proc USES bx cx
	mov eax, 0
	L1:
		L2:
		inc eax
		dec cx
		loop L2
	dec bx
	loop L1
	ret
nestedLoops endp

;question 2
charA proc
	movzx eax, varA
	call charB
	ret
charA endp

charB proc
	movzx eax, varB
	call charC
	ret
charB endp

charC proc
	movzx eax, varC
	ret
charC endp

end main
