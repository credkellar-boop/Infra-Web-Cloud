CC=clang
CFLAGS=-O3 -march=native -Wall

all: benchmark_runner

benchmark_runner: net_bench.c
	$(CC) $(CFLAGS) net_bench.c -o benchmark_runner

clean:
	rm -f benchmark_runner
