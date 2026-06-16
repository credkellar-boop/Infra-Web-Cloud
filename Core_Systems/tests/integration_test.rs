use tokio::sync::mpsc;
use std::sync::Arc;

#[tokio::test]
async fn test_core_pipeline_throughput() {
    let (tx, mut rx) = mpsc::channel(100);
    let ingestor = Arc::new(infra_core_orchestrator::telemetry::TelemetryIngestor::new(tx));

    // Simulate high-frequency binary packet inject streams
    let mock_packet = vec![0x4D, 0x01, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x01, 0x0A, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00];
    
    let handle = ingestor.process_ring_buffer_stream(mock_packet);
    handle.await;

    let received = rx.recv().await.unwrap();
    assert_eq!(received.pid, 16843085); // Verify structural endian decoding matches exactly
}
