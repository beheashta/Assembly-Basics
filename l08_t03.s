/*
-------------------------------------------------------
find_common.s
Working with stack frames.
-------------------------------------------------------
Author:
ID:
Email:
Date:    2020-12-14
-------------------------------------------------------
*/
// Constants
.equ SIZE, 80

.org    0x1000    // Start at memory location 1000
.text  // Code section
.global _start
_start:

// push parameters onto the stack
LDR R0, =first
LDR R1, =second
LDR R2, =common
LDR R3, =SIZE
STMFD SP!,{R3}			// Push the max size of common on stack
STMFD SP!,{R2}			// Push the address of common on stack
STMFD SP!, {R1}			// Push the address of second on stack
STMFD SP!, {R0}			// Push the address of first on stack

BL     FindCommon
// clean up the stack
ADD SP, SP, #12




_stop:
B      _stop

//-------------------------------------------------------
FindCommon:
/*
-------------------------------------------------------
Equivalent of: FindCommon(*first, *second, *common, size)
Finds the common parts of two null-terminated strings from the beginning of the
strings. Example:
first: "pandemic"
second: "pandemonium"
common: "pandem", length 6
-------------------------------------------------------
Parameters:
  first - pointer to start of first string
  second - pointer to start of second string
  common - pointer to storage of common string
  size - maximum size of common
Returns:
	R2 - address of common string
Uses:
  R0 - address of first
  R1 - address of second
  R2 - address of common
  R3 - value of max length of common
  R4 - character in first
  R5 - character in second
-------------------------------------------------------
*/
// set up stack
STMFD  SP!, {FP, LR}			// Push the fp and link register on the stack
MOV    FP, SP					// Save the current stack top to fp

// Allocate local storage
STMFD  SP!, {R0-R1,R3-R5}   	// Preserve the other registers

// extract parameters
LDR R0, [FP,#8] 				// Get the address of first
LDR R1, [FP,#12] 				// Get the address of second
LDR R2, [FP, #16]				// Get the address of common
LDR R3, [FP,#20]				// Max size of common


FCLoop:
CMP    R3, #1          // is there room left in common?
BEQ    _FindCommon     // no, leave subroutine
LDRB   R4, [R0], #1    // get next character in first
LDRB   R5, [R1], #1    // get next character in second
CMP    R4, R5
BNE    _FindCommon     // if characters don't match, leave subroutine
CMP    R5, #0          // reached end of first/second?
BEQ    _FindCommon
STRB   R4, [R2], #1    // copy character to common
SUB    R3, R3, #1      // decrement space left in common
B      FCLoop

_FindCommon:
MOV    R4, #0
STRB   R4, [R2]       // terminate common with null character

// clean up stack
LDMFD SP!, {R0-R1,R3-R5} 	// pop the preserved registers
LDMFD SP!, {FP, PC} 		// pop fp and pc

//-------------------------------------------------------
.data
.align
first:
.asciz "pandemic"
.align
second:
.asciz "pandemonium"
.align
common:
.space SIZE

.end
