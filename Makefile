main:
	mkdir build
	make -C miniML
clean:
	rm -rf ./build
	make -C miniML clean
run:
	./build/mml
