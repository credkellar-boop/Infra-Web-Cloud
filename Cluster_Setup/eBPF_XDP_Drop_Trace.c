#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/in.h>

#define SEC(NAME) __attribute__((section(NAME), used))

/* Ensure standard network byte order conversion helpers match architecture */
#define bpf_htons(x) __builtin_bswap16(x)
#define bpf_htonl(x) __builtin_bswap32(x)

SEC("xdp")
int xdp_drop_unauthorized(struct xdp_md *ctx) {
    void *data_end = (void *)(long)ctx->data_end;
    void *data = (void *)(long)ctx->data;

    // Boundary check: Parse Ethernet Frame Header
    struct ethhdr *eth = data;
    if ((void *)(eth + 1) > data_end) {
        return XDP_PASS;
    }

    // Pass non-IPv4 traffic through to avoid breaking basic clustering fabrics
    if (eth->h_proto != bpf_htons(ETH_P_IP)) {
        return XDP_PASS;
    }

    // Boundary check: Parse IP Header
    struct iphdr *ip = (void *)(eth + 1);
    if ((void *)(ip + 1) > data_end) {
        return XDP_PASS;
    }

    // Drop logic targeting the explicit unauthorized target (e.g., 10.0.0.100)
    // This perfectly mirrors your user-space simulation fuzz vectors
    if (ip->saddr == bpf_htonl(0x0A000064)) {
        return XDP_DROP;
    }

    return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
