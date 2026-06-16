CC=clang
CFLAGS=-O2 -g -Wall
BPFTOOL=bpftool

all: bpf_program

bpf_program: eBPF_XDP_Drop_Trace.c
	$(CC) $(CFLAGS) -target bpf -c ../../Cluster_Setup/eBPF_XDP_Drop_Trace.c -o xdp_drop_trace.o

clean:
	rm -f xdp_drop_trace.o
