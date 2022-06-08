
; Ryan Brisbane
; this program takes an array of 10,000 numbers and "marks" each non-prime number with a value of 1 at the index of the given number
; it also prints the primes between 1-10000 in a pretty shade of magenta at the end
; Last update: April 1st, 2021 at 1:45 AM

INCLUDE Irvine32.inc
.data
array BYTE 10000 DUP(0)

.code
Sieve proc uses eax ebx ecx esi
	mov ecx, 1
	mov array[ecx], 1
	mov esi, 2
	;while p is less than 10000
	L1:
		mov esi, 2
		;if p is above 10000, break out of the loop
		inc ecx
		cmp ecx, 10000
		ja next1
		;if p is already marked as prime, move directly to the next value of p
		movzx ebx, array[ecx]
		cmp ebx, 1
		je L1
		L2:
			;multiply p by esi, storing it in eax to preserve ecx. change the value of the array at eax to 1 as it is not prime
			mov eax, ecx
			mul esi ;multiply p by esi (2p, 3p, 4p, etc).
			cmp eax, 10000 ;verify that our number is less than 10000. if not, move on to the next p value
			ja L1
			mov array[eax], 1
			inc esi
			jmp L2
	next1:
	ret
Sieve endp

;Procedure that prints out all the prime values (0 at index ecx) of our array
PrintArray proc uses eax ecx edx
	mov eax, lightMagenta ;I've assumed this is the color you want, purely based on the font color of the one spot of the bonus question
	call SetTextColor
	mov ecx, 1 ;I skip zero because our range is 1-10000
	L3:
		cmp ecx, 10000 ;verifying that we're within our range, breaks out of the loop once we pass 10000.
		ja next2
		
		movzx edx, array[ecx]
		cmp edx, 1 ;verifying that our value is prime. if not, disregard and move onto the next value
		je continue
		mov eax, ecx
		call Crlf
		call WriteDec ;print our number to the console
		continue:
			inc ecx
			jmp L3
	next2:
	ret
PrintArray endp

main PROC
	call Sieve
	call PrintArray
	exit
main ENDP
END main