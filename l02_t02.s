/*
-------------------------------------------------------
l02_t02.s
Assign to and add contents of registers.
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

// Copy data from memory to registers
LDR	R3, =First
LDR	R0, [R3]
LDR	R3, =Second
LDR	R1, [R3]
// Perform arithmetic and store results in memory
ADD	R2, R0, R1
LDR	R3, =Total
STR	R2, [R3]
SUB	R2, R0, R1	// Subtract Second from First
LDR	R3, =Diff
STR	R2, [R3]
// End program
_stop:
B _stop

.data	// Initialized data section
First:
.word	4
Second:
.word	8
.bss	// Uninitialized data section
Total:
.space 4	// Set aside 4 bytes for total
Diff:
.space 2	// Set aside 4 bytes for difference

.end

// label on line 27 was mismatched spelling to where it was declared on line 41
// line 25 and line 28 were missing [] on R3 for memory address refrencing
