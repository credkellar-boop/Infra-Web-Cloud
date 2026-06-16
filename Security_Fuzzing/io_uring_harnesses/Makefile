CC=clang
CFLAGS=-O3 -g -fsanitize=fuzzer,address
LIBS=-luring

all: io_uring_fuzz_target

io_uring_fuzz_target: uring_harness.c
	$(CC) $(CFLAGS) uring_harness.c -o io_uring_fuzz_target $(LIBS)

clean:
	rm -f io_uring_fuzz_target
