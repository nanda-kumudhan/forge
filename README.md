# NixOS Configuration

Personal NixOS configuration for running NixOS 26.05 (Yarara), with Sway/Wayland, TLP battery management, virtualization, development tooling, and a broad desktop application environment.

## System Overview

| Component | Configuration |
|---|---|
| Hostname | `forge` |
| OS | NixOS 26.05 (Yarara) |
| Architecture | x86_64 |
| Kernel | 6.18.53 |
| Init | systemd 260.4 |
| Desktop | Sway 1.12 |
| Display Protocol | Wayland |
| Display | 1920×1080 @ 60 Hz |
| Shell | Bash 5.3.9 |
| Terminal | foot 1.27.0 |
| Font | JetBrainsMono Nerd Font |
| Audio | PipeWire |
| Network | NetworkManager |
| Bluetooth | BlueZ |
| Firewall | Enabled |
| Bootloader | systemd-boot |
| Virtualization | KVM/QEMU, libvirt, Podman, Docker, Waydroid |
| Battery management | TLP |
| Battery thresholds | 75–80% |

---

## Repository Layout

```text
/etc/nixos/
├── configuration.nix
└── hardware-configuration.nix
