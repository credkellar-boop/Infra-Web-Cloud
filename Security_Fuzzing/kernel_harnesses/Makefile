CC=clang
CFLAGS=-O2 -g -fsanitize=address,undefined

all: ebpf_fuzz_target

ebpf_fuzz_target: fuzz_harness.c
	$(CC) $(CFLAGS) fuzz_harness.c -o ebpf_fuzz_target

clean:
	rm -f ebpf_fuzz_target
