// Assembly example code for Apple Silicon
// Shows how a dylib can be written in Assembly
// and used by Rust

// System call ABI
// X0-X2 - parameters to Unix system calls
// X16 - Mach System Call function number

// Exported symbols
.global _main	// Provide program starting address to linker
.global _add
.global _sub
.global _upp

.align 4	// Make sure everything is aligned properly

_main: 
	// Print the "hello world" string
	mov	X0, #1		// 1 = StdOut
	adr	X1, helloworld 	// string to print
	mov	X2, #13	    	// length of our string
	mov	X16, #4		// Unix write system call
	svc	#0x80		// Call kernel to output the string


	// Add two numbers
	mov	x0, #50
	mov	x1, #3
	bl	_add
	// Print the result with printf
	// printf takes variadic argumetns, which are pushed on the stack
	// in reverse order. The first argument is the format string.
	str	x0, [sp, #-16]! // = push x0 -> 16 byte alignment (result from add)
        adr	x0, format	// format string
        bl      _printf
        ldr     w0, [sp, #16]	// = pop x0

	// Print the "lower" string
	mov	X0, #1		// 1 = StdOut
	adrp	X1, lower@PAGE 	// string to print
	add	X1, X1, lower@PAGEOFF
	mov	X2, #13	    	// length of our string
	mov	X16, #4		// Unix write system call
	svc	#0x80		// Call kernel to output the string

	// Convert the "lower" string to uppercase
	adrp	x0, lower@PAGE
	add	x0, x0, lower@PAGEOFF
	bl	_upp

	// Print the "lower" string
	mov	X0, #1		// 1 = StdOut
	adrp	X1, lower@PAGE	// string to print
	add	X1, X1, lower@PAGEOFF
	mov	X2, #13		// length of our string
	mov	X16, #4		// Unix write system call
	svc	#0x80		// Call kernel to output the string



	// Setup the parameters to exit the program
	// and then call the kernel to do it.
	mov     X0, #0		// Use 0 return code
	mov     X16, #1		// System call number 1 terminates this program
	svc     #0x80		// Call kernel to terminate the program

// Function to add two numbers
// x0 = first number
// x1 = second number
// returns x0 + x1
_add:	sub	sp, sp, #16 
	str	x0, [sp, #8]
	str	x1, [sp]

	ldr	x8, [sp, #8]
	ldr	x9, [sp]
	add	x0, x8, x9

	add	sp, sp, #16
	ret

// Function to subtract two numbers
// x0 = first number
// x1 = second number
// returns x0 - x1
_sub:	sub	sp, sp, #16 
	str	x0, [sp, #8]
	str	x1, [sp]

	ldr	x8, [sp, #8]
	ldr	x9, [sp]
	sub	x0, x8, x9

	add	sp, sp, #16
	ret

// Function to convert a string to uppercase in place
// x0 = address of string
// returns nothing
_upp:
	sub	sp, sp, #16 
	str	x0, [sp, #8]	// Address of string

	mov	x1, x0		// x1 = address of string = pointer to character
	mov	x2, xzr		// x2 = 0 = loop counter
loop:
	add	x3, x1, x2	// x3 (address of char) = x1 (address of string) + x2 (loop counter)
	ldrb	w4, [x3]	// load char into w4
	cbz	x4, end		// compare zero, if zero, branch to end

	cmp	w4, #'a'	// compare with 'a'
	blt	inc		// if less than 'a', branch to inc
	cmp	w4, #'z'	// compare with 'z'
	bgt	inc		// if greater than 'z', branch to inc

	eor	w4, w4, #32	// convert to uppercase
	strb	w4, [x3]	// store back to memory
inc:
	add	x2, x2, #1	// increment counter
	b	loop		
end:
	add	sp, sp, #16
	ret

// RO data section
helloworld:     .asciz "Hello World!\n"
format:		.asciz "Result: %ld\n"

// RW data section
.data
lower:		.asciz "hello"
