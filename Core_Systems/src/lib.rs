pub mod telemetry;
pub mod crypto;

// Global architectural constants for high-throughput memory bounds tracking
pub const EBPF_FRAME_MIN_SIZE: usize = 16;
pub const MAX_BLOCKCHAIN_PAYLOAD_SIZE: usize = 1024 * 1024; // 1MB Maximum
