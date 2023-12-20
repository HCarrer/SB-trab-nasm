clean-filter:
	cd filter && rm -rf filter.o a.out && cd ..

run-filter:
	cd filter && nasm -felf64 filter.asm && ld filter.o && ./a.out && xdg-open text.txt && cd ..

clean-switch:
	cd switch && rm -rf switch.o a.out && cd ..

run-switch:
	cd switch && nasm -felf64 switch.asm && ld switch.o && ./a.out && cd ..