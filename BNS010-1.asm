
; This program takes a string and converts all lowercase letters to uppercase letters, as well as converts periods to exclamation points
; It then writes the string to the console, in yellow if the string is above 5 characters in length, and in red if above 10
; Last update: Friday April 30th, 2021 at 6:30 pm
; Ryan Brisbane, COSC 350

INCLUDE Irvine32.inc
.data
	str1 BYTE "test string. testing testing 1, 2",0
.code

Shout proc
	L1:
	mov al, [esi]
	cmp al, 0 ;test if we've reached the end of the string
	je exitProc
	cmp al, 00101110b ;test if we're looking at a period, and jump to the appropriate point if so
	je exclamation

	cmp al, 01100001b ;test if we're within a-z
	jl noChanges ;if it's a special character besides a period, move to the next character
	cmp al, 01111010b ;if it's within a-z, convert it to uppercase
	jle uppercase
	inc esi
	jmp L1
	
	noChanges: ;for characters other than a-z and periods
		inc esi
		jmp L1

	exclamation: ;converts periods to exclamation points
		mov al, 00100001b
		mov [esi], al
		inc esi
		jmp L1

	uppercase: ;converts lowercase letters (a-z) to uppercase letters (A-Z)
		AND al, 11011111b
		mov [esi], al
		inc esi
		jmp L1
		
	exitProc: ;once we've reached the end of the string
		cmp ecx, 10
		jg setRed ;change text color based on length
		cmp ecx, 5
		jg setYellow
		

		setYellow:
			mov eax, 14 ;sets text color to yellow
			call SetTextColor
			jmp write
		setRed:
			mov eax, 4 ;sets text color to red
			call SetTextColor
		write: ;writes the altered string to the console
			mov edx, OFFSET str1
			call WriteString
	ret
Shout endp

main PROC

	mov esi, OFFSET str1
	mov ecx, LENGTHOF str1
	push esi
	push ecx
	call Shout

	exit
main ENDP
END main