const std = @import("std");

pub const RpcHeader = struct {
    magic_byte: u8,
    version: u8,
    payload_len: u32,
    checksum: u32,
};

pub fn parseIncomingRpcFrame(buffer: []const u8) !RpcHeader {
    if (buffer.len < 10) {
        return error.BufferUnderflow;
    }

    const magic = buffer[0];
    const version = buffer[1];
    
    // Memory-safe extraction utilizing slice boundaries
    const payload_len = std.mem.readInt(u32, buffer[2..6], .little);
    const checksum = std.mem.readInt(u32, buffer[6..10], .little);

    if (magic != 0x4D) { // 'M' for Monad validation protocol framing
        return error.InvalidProtocolMagic;
    }

    return RpcHeader{
        .magic_byte = magic,
        .version = version,
        .payload_len = payload_len,
        .checksum = checksum,
    };
}
