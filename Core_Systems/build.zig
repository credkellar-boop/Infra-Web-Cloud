const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .bpfel,
        .os_tag = .freestanding,
    });

    const optimize = b.standardOptimizeOption(.{});

    const obj = b.addObject(.{
        .name = "xdp_drop_trace",
        .root_source_file = .{ .path = "../Cluster_Setup/eBPF_XDP_Drop_Trace.c" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(obj);
}
