use anyhow::Context;
use aya::Bpf;
use aya::programs::{Xdp, XdpFlags};
use log::info;
use std::env;

#[tokio::main]
async fn main() -> Result<(), anyhow::Error> {
    env_logger::init();
    info!("Initializing Infra-Web-Cloud core eBPF orchestrator...");

    let mut bpf = Bpf::load_file("../Cluster_Setup/xdp_drop_trace.o")
        .context("Failed to load eBPF object file")?;

    let program: &mut Xdp = bpf.program_mut("xdp_drop_unauthorized").unwrap().try_into()?;
    program.load()?;
    program.attach("eth0", XdpFlags::default())
        .context("Failed to attach the XDP program to interface")?;

    info!("XDP kernel boundaries enforced. Awaiting telemetry...");
    tokio::signal::ctrl_c().await?;
    info!("Shutting down orchestrator.");
    Ok(())
}
