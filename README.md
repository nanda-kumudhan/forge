# Forge NixOS Configuration

Personal NixOS configuration for the `forge` x86_64 system, targeting NixOS
26.05. It provides a Sway/Wayland desktop, development tools, containers,
virtualization, hardware support, and security services.

## Highlights

- **Desktop:** Sway, Wayland portals, PipeWire, Ly, Bluetooth, printing, and
  Flatpak.
- **Kernels:** LTS by default, with `linuxPackages_latest` available through
  the `latest-kernel` systemd-boot specialisation.
- **Virtualization:** QEMU/KVM through libvirt and virt-manager, with SPICE
  USB redirection, Podman, Docker, Distrobox, and Waydroid.
- **Development:** C/C++, Java, Python, Rust, Go, Ruby, Kubernetes, Arduino,
  LaTeX, DBeaver, Helix, Neovim, and Zed.
- **Security:** TPM2 support, AppArmor, kernel lockdown integrity mode, and
  `sbctl` for manual Secure Boot signing.

## Current approach

This repository deliberately uses the traditional stable NixOS channel
workflow for now. Flakes are not being used while the syntax and workflow are
still being learned, and Lanzaboote is not being used after a boot failure
involving the `lzbt` issue. The configuration uses native systemd-boot with
manual `sbctl` signing instead.

## Layout

```text
.
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

`configuration.nix` assembles the modules. Hardware discovery is kept in
`hardware-configuration.nix`; services and feature groups live under
`modules/`.

## Usage

Add the stable channel once:

```bash
sudo nix-channel --add https://channels.nixos.org/nixos-26.05 nixos
sudo nix-channel --update
```

Copy or symlink this repository into `/etc/nixos`, then build the
channel-based configuration:

```bash
sudo nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix
```

The configuration keeps kernel lockdown in integrity mode with
`boot.kernelParams = [ "lockdown=integrity" ];`. After rebuilding with Secure
Boot enabled, verify and sign new EFI files with `sbctl` as required by the
local key setup.
