use std::sync::Arc;
use tokio::sync::mpsc;
use log::{error, info};

#[derive(Debug, Clone)]
pub struct KernelNetworkEvent {
    pub pid: u32,
    pub source_address: u32,
    pub dest_address: u32,
    pub source_port: u16,
    pub dest_port: u16,
}

pub struct TelemetryIngestor {
    event_sender: mpsc::Sender<KernelNetworkEvent>,
}

impl TelemetryIngestor {
    pub fn new(tx: mpsc::Sender<KernelNetworkEvent>) -> Self {
        Self { event_sender: tx }
    }

    pub async fn process_ring_buffer_stream(self: Arc<Self>, mut raw_bytes: Vec<u8>) {
        if raw_bytes.len() < 16 {
            error!("Malformed eBPF telemetry frame dropped.");
            return;
        }

        // Deconstruct packet frame directly using memory safe bounds shifts
        let pid = u32::from_le_bytes(raw_bytes[0..4].try_into().unwrap());
        let source_address = u32::from_le_bytes(raw_bytes[4..8].try_into().unwrap());
        let dest_address = u32::from_le_bytes(raw_bytes[8..12].try_into().unwrap());
        
        let event = KernelNetworkEvent {
            pid,
            source_address,
            dest_address,
            source_port: 0, 
            dest_port: 0,
        };

        if let Err(e) = self.event_sender.send(event).await {
            error!("Failed to route event to downstream monitoring core: {}", e);
        }
    }
}
