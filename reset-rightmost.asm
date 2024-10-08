; reset-rightmost.asm
; CSC 230: Fall 2022
;
; Code provided for Assignment #1
;
; Mike Zastre (2022-Sept-22)

; This skeleton of an assembly-language program is provided to help you
; begin with the programming task for A#1, part (b). In this and other
; files provided through the semester, you will see lines of code
; indicating "DO NOT TOUCH" sections. You are *not* to modify the
; lines within these sections. The only exceptions are for specific
; changes announced on conneX or in written permission from the course
; instructor. *** Unapproved changes could result in incorrect code
; execution during assignment evaluation, along with an assignment grade
; of zero. ****
;
; In a more positive vein, you are expected to place your code with the
; area marked "STUDENT CODE" sections.

; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; Your task: You are to take the bit sequence stored in R16,
; and to reset the rightmost contiguous sequence of set
; by storing this new value in R25. For example, given
; the bit sequence 0b01011100, resetting the right-most
; contigous sequence of set bits will produce 0b01000000.
; As another example, given the bit sequence 0b10110110,
; the result will be 0b10110000.
;
; Your solution must work, of course, for bit sequences other
; than those provided in the example. (How does your
; algorithm handle a value with no set bits? with all set bits?)

; ANY SIGNIFICANT IDEAS YOU FIND ON THE WEB THAT HAVE HELPED
; YOU DEVELOP YOUR SOLUTION MUST BE CITED AS A COMMENT (THAT
; IS, WHAT THE IDEA IS, PLUS THE URL).

    .cseg
    .org 0

; ==== END OF "DO NOT TOUCH" SECTION ==========

	ldi R16, 0b01011100
	; ldi R16, 0b10110110

	; THE RESULT **MUST** END UP IN R25

; **** BEGINNING OF "STUDENT CODE" SECTION **** 

; Your solution here.

;use R18 to hold counter value
LDI r18, 9

MOV r17, r16

; Sourced from https://www.arxterra.com/6-avr-looping/
; Loops for 9 times and rotates r16, and if carry flag = 1 then it branches to found_one
LOOP:	
	ROR r17
	BRCS FOUND_ONE
	
	HERE:
	DEC r18
	BRNE LOOP

JMP EXIT

; When it finds the first continigous bit, it will count the amount of bits there
FOUND_ONE:
	BRCC FINISHED
	INC r20
	ROR r17
	JMP FOUND_ONE

; Branches here when the contigious bits are finished
FINISHED:
	MOV r17, r16
	LDI r18, 9
	; This loop rotates through r17, a copy of r16, which stops when it finds the first contiguous bit
	LOOP2:
		ROR r17
		BRCS FOUND_ONE_2
		DEC r18
		BRNE LOOP2
		JMP EXIT

	; This resets the right-most contiguous bits
	FOUND_ONE_2:
		LSR r17
		DEC r18
		DEC r20
		BRNE FOUND_ONE_2	

	; This finishes off all rotation and sets it to the previous position with right-most contiguous bits reset
		DEC r18
	LOOP3:
		ROR r17
		DEC r18
		BRNE LOOP3

EXIT:

MOV r25, r17

; **** END OF "STUDENT CODE" SECTION ********** 



; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
reset_rightmost_stop:
    rjmp reset_rightmost_stop


; ==== END OF "DO NOT TOUCH" SECTION ==========
