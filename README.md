# Forge — Personal NixOS configuration

This repository contains a personal NixOS configuration for the "forge" x86_64
machine. It is primarily tested against NixOS 26.05 using the traditional
channel-based workflow. A `flake.nix` is present but the channel workflow is
the documented, supported approach here.

Goals
- Minimal, reproducible desktop with Sway/Wayland
- Full developer toolset (C/C++, Rust, Go, Python, Java, editors)
- Virtualization (QEMU/KVM, libvirt, Podman) and container tooling
- Hardware support and power management for laptops/desktops
- Hardened security defaults (TPM2, kernel lockdown, AppArmor, sbctl)

Key features
- Sway, PipeWire, Wayland portals, Ly (login manager), Flatpak, printing
- LTS kernel by default; an option exists for `linuxPackages_latest`
- libvirt/QEMU, virt-manager, SPICE USB redirection, Podman/Distrobox
- TPM2 and sbctl-based Secure Boot signing workflow

Repository layout

- configuration.nix — top-level configuration that imports modules
- hardware-configuration.nix — hardware-specific auto-detected options
- modules/ — grouped module files (boot, desktop, hardware, networking,
  packages, security)
- flake.nix & flake.lock — present for experimentation (not the recommended
  workflow here)
- assets/ — images and other static assets

Quickstart (channel-based)

1. Add the NixOS 26.05 channel (run once):

   sudo nix-channel --add https://channels.nixos.org/nixos-26.05 nixos
   sudo nix-channel --update

2. Install the configuration:

   # copy or symlink this repo to /etc/nixos
   sudo nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix

Notes on Secure Boot
- This configuration enables kernel lockdown (integrity mode). If Secure
  Boot is enabled, sign new EFI files with `sbctl` according to your local
  key setup after upgrading the system.

Using flakes (optional)
- A `flake.nix` exists for experimentation. If you prefer flakes, inspect
  `flake.nix` to find the system name, then use e.g.

  sudo nixos-rebuild switch --flake /etc/nixos#forge

  (Replace `forge` with the appropriate output defined by the flake.)

Contributing / customization
- Modules are small and focused. Add changes in `modules/` and reference them
  from `configuration.nix`.
- Hardware changes belong in `hardware-configuration.nix`.

Author
- Maintained by @nanda-kumudhan

License
- See repository for license information.
