use anyhow::{Context, Result};
use aya::{Bpf, programs::{Xdp, XdpFlags}};
use log::{info, warn};

pub struct BpfHookManager {
    bpf_instance: Bpf,
}

impl BpfHookManager {
    pub fn load_from_file(path: &str) -> Result<Self> {
        let bpf = Bpf::load_file(path)
            .with_context(|| format!("Failed to initialize eBPF bytecode matrix from {}", path))?;
        Ok(Self { bpf_instance: bpf })
    }

    pub fn attach_xdp_program(&mut self, program_name: &str, interface: &str) -> Result<()> {
        let program: &mut Xdp = self.bpf_instance
            .program_mut(program_name)
            .context("Target XDP program context identifier not discovered in object definitions")?
            .try_into()?;

        program.load().context("Failed to load XDP logic into kernel memory context")?;
        
        program.attach(interface, XdpFlags::default())
            .with_context(|| format!("Failed to bind XDP interface mapping to target device: {}", interface))?;

        info!("Successfully bound kernel boundary program [{}] to physical link: {}", program_name, interface);
        Ok(())
    }
}
