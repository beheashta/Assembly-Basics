/*
-------------------------------------------------------
l03_t02.s
A simple count down program (BGE)
-------------------------------------------------------
Author:  David Brown
ID:      999999999
Email:   dbrown@wlu.ca
Date:    2020-12-14
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

// Store data in registers
LDR R0, =Counter	// Initialize a countdown value
LDR R3, [R0]	
TOP:
SUB	R3, R3, #1	// Decrement the countdown value
CMP	R3, #0		// Compare the countdown value to 0
BGE	TOP	        // Branch to TOP if > 0

_stop:
B	_stop
.data
// Counter in Hexadecimal (stored in r0) was 00001020
Counter:
.word 5
.end