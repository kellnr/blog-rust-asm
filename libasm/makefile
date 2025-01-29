exe: Math.o
	ld -o Math Math.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64

dylib: Math.o
	ld -o libMath.dylib Math.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64 -dylib 

Math.o: Math.s
	as -arch arm64 -o Math.o math.s

clean:
	rm -f Math Math.o libMath.dylib
