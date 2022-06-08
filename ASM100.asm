
; ASM100
; Last update: wednesday, march 24th
; Ryan Brisbane
; i'm using lots of comments this time!!! be proud of me please!!!

INCLUDE Irvine32.inc
.data
my_var DWORD ? ; for use in question 0

UpperArray DWORD 9,8,6,7,5
LowerArray DWORD 1,2,4,3,4
;TestArray DWORD 5 DUP(?) 
;used that when didn't have actual test array. whether i need it or not, who knows
TestArray DWORD 10,3,5,4,5

.code

;question 0 (named rightly so because i'm not sure how else to name it)
Question0 PROC
	cmp edx, eax ; edx>eax ?
		jg yes ; jump to the line that occurs if the whole statement is true, since the OR becomes true if one side does
	cmp ebx, ecx ;if we've made it here the previous statement was false. compares ebx and ecx
		jb no ;if ebx < ecx, proceed directly to the false condition. the AND becomes false with one side false, and the OR has both sides false now
	cmp ecx, edx ;previous statement is true, compares ecx and edx now
		ja no ;if ecx > edx, we proceed to the false condition
	yes:
		mov my_var, 10000000h
		jmp next ;skips the false condition so it doesn't do that too
	no:
		mov my_var, 20000000h
	next: ;proceeds onward to whatever's next
	ret
Question0 endp

;question 2. my sworn enemy. we meet at last
VALIDATE_PIN proc uses eax ecx ;i'm actually REALLY proud of this one
	mov ecx, 0 ;set loop counter to 0
	L2:
		cmp ecx, 5 ;compare ecx to 5
		ja stop ;if ecx > 5, jump to the end. we've covered the whole PIN
			mov ebx, TestArray[ecx] ;store the test value at [ecx] in ebx for comparison
			mov edx, UpperArray[ecx] ;store the upper limit value at [ecx] in edx
			cmp ebx, edx ;compare the test PIN's number at index [ecx] to the same value at index [ecx] of the upper limit array
			jg mismatch ;if the test value is > than 9, it breaks the rules. jump to the condition provided in this event
			mov ebx, TestArray[ecx]
			mov edx, LowerArray[ecx]
			cmp ebx, edx ;compare the test value to the lower limit array at index [ecx]
			jl mismatch ;same idea. if the test value is less than the limit, jump to the mismatch condition
		inc ecx ;we get here if the test value at index [ecx] is within the limits. increment ecx to proceed to the next index
		jmp L2 ;restart the loop to test the next value
	mismatch:
		mov eax, ecx ;in the event of a mismatch, the index at which there was a problem is sent to eax
		jmp next ;skips the condition that happens if no mismatches were found
	stop:
		mov eax, -1 ;only occurs if no mismatches were found
	next:
	ret
VALIDATE_PIN endp ;wow! so many comments! how wacky and uncharacteristic of me!

main PROC
; question 1
	L1: 
		cmp eax, 1 ;compares eax to 1
		jg body ; if eax > 1, proceed to the loop body immediately
		cmp ebx, 2 ;compares ebx to 2 in the event the first condition is false
		jg body ;proceeds to the body if ebx > 2
		jmp next ;if both are false, break the loop
		body:
			dec eax
			dec ebx
		loop L1 ;jumps back to the start to continue looping
		next: ;proceeds onward if both conditions are false

	mov eax, 4
	mov ebx, 8
	mov ecx, 1
	mov edx, 3 ;mathed this out on paper. my_var should be 10000000h

	call Question0
	call VALIDATE_PIN

	exit
main ENDP
END main