const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "parser_fuzz_target",
        .root_source_file = .{ .path = "fuzz_parser.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.linkLibC();
    b.installArtifact(exe);
}
