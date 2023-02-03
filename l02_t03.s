/*
-------------------------------------------------------
l02_t03.s
Copies contents of one vector to another.
-------------------------------------------------------
Author:  Beheashta Atchekzai
ID:      190637520
Email:   atch7520@mylaurier.ca
Date:    2022-01-22
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

.text	// code section
// Copy contents of first element of Vec1 to Vec2
LDR	R0, =Vec1 // assign address of Vec 1 to R0
LDR	R1, =Vec2 // assign address of Vec 2 to R1
LDR	R2, [R0] // load R2 from the memory address of R0
STR	R2, [R0] // store from the memory address of R0 into R2
// Copy contents of second element of Vec1 to Vec2
ADD	R0, R0, #2 // add r0 and 2 together and store its value into r0
ADD	R1, R1, #2 // add r1 and 2 together and store its value back into r1
LDR	R2, [R1] // load R2 from the memory address of r1
STR	R2, [R1] 
// Copy contents of third element of Vec1 to Vec2
ADD	R1, R1, #4
ADD	R1, R1, #4
LDR	R2, [R0]
STR	R2, [R2]
// End program
_stop:
B _stop

.data	// Initialized data section
Vec1:
.word	1, 2, 3
.bss	// Uninitialized data section
Vec2:
.word	4

.end

// the comment on line 28 said second when it meant to say third
// line 42 the .word is 4 bytes in ARM not 6
