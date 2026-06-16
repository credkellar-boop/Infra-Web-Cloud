use std::env;
use log::warn;

pub struct OrchestratorConfig {
    pub rpc_endpoint: String,
    pub worker_threads: usize,
}

impl OrchestratorConfig {
    pub fn load_from_env() -> Self {
        let rpc_endpoint = env::var("MONAD_RPC_URL")
            .unwrap_or_else(|_| {
                warn!("MONAD_RPC_URL missing. Defaulting to local high-throughput loopback bypass.");
                "http://127.0.0.1:8545".to_string()
            });

        Self {
            rpc_endpoint,
            worker_threads: std::thread::available_parallelism()
                .map(|n| n.get())
                .unwrap_or(4),
        }
    }
}
