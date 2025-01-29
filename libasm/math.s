//
// Assembler program to print "Hello World!"
// to stdout.
//
// X0-X2 - parameters to Unix system calls
// X16 - Mach System Call function number
//

.global _main			// Provide program starting address to linker
.global _add
.align 4			// Make sure everything is aligned properly

// Setup the parameters to print hello world
// and then call the Kernel to do it.
_main: mov	X0, #1		// 1 = StdOut
	adr	X1, helloworld 	// string to print
	mov	X2, #13	    	// length of our string
	mov	X16, #4		// Unix write system call
	svc	#0x80		// Call kernel to output the string

	sub 	sp, sp, #16

	mov	x0, #50
	mov	x1, #3
	bl	_add


	str x0, [sp, #-16]! // = push x0 -> 16 byte alignment
        adr    x0, format
        bl      _printf
        ldr     w0, [sp, #16] // = pop x0


// Setup the parameters to exit the program
// and then call the kernel to do it.
	mov     X0, #0		// Use 0 return code
	mov     X16, #1		// System call number 1 terminates this program
	svc     #0x80		// Call kernel to terminate the program

_add:	sub	sp, sp, #16 
	str	x0, [sp, #8]
	str	x1, [sp]

	ldr	x8, [sp, #8]
	ldr	x9, [sp]
	add	x0, x8, x9

	add	sp, sp, #16
	ret

helloworld:      .ascii  "Hello World!\n"
format:		.ascii "Result: %ld\n"
