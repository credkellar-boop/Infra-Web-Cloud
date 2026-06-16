CC=clang
CFLAGS=-O2 -g -fsanitize=hwaddress,fuzzer -Wall -Wextra

all: mem_leak_target

mem_leak_target: alloc_fuzzer.c
	$(CC) $(CFLAGS) alloc_fuzzer.c -o mem_leak_target

clean:
	rm -f mem_leak_target
