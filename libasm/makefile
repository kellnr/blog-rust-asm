exe: Asm.o
	ld -o Asm Asm.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64

dylib: Asm.o
	ld -o libAsm.dylib Asm.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64 -dylib 

Asm.o: Asm.s
	as -arch arm64 -o Asm.o asm.s

clean:
	rm -f Asm Asm.o libAsm.dylib
