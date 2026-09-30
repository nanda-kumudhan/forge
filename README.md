# NixOS Configuration

Personal NixOS configuration for NixOS 26.05, with Sway/Wayland, TLP
battery management, virtualization, development tooling, and a broad
desktop application environment.

## System Overview

| Component | Configuration |
|---|---|
| Hostname | `forge` |
| OS | NixOS 26.05 (Yarara) |
| Architecture | x86_64 |
| Default kernel | LTS |
| Alternate kernel | Latest, through a systemd-boot specialisation |
| Desktop | Sway/Wayland |
| Shell | Bash with Starship |
| Terminal | foot |
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

The repository is organised as a flake with feature-specific modules:

```text
.
├── flake.nix
├── flake.lock
├── configuration.nix
├── hardware-configuration.nix
└── modules
    ├── boot.nix
    ├── desktop.nix
    ├── hardware.nix
    ├── networking.nix
    ├── packages.nix
    └── security.nix
```

`configuration.nix` assembles the modules. Hardware discovery remains in
`hardware-configuration.nix`; service and feature configuration is grouped
under `modules/`.
