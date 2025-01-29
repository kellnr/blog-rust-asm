exe: HelloWorld.o
	ld -o HelloWorld HelloWorld.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64

dylib: HelloWorld.o
	ld -o HelloWorld.dylib HelloWorld.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64 -dylib 

HelloWorld.o: HelloWorld.s
	as -arch arm64 -o HelloWorld.o HelloWorld.s

clean:
	rm -f HelloWorld HelloWorld.o HelloWorld.dylib
