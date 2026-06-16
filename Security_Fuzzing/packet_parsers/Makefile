CC=clang
CFLAGS=-O2 -g -fsanitize=fuzzer,address,undefined

all: parser_fuzz_target

parser_fuzz_target: fuzz_parser.c
	$(CC) $(CFLAGS) fuzz_parser.c -o parser_fuzz_target

clean:
	rm -f parser_fuzz_target
