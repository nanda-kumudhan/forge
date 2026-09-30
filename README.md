# Forge NixOS Configuration

Personal NixOS flake for the `forge` x86_64 system, targeting NixOS 26.05.
It provides a Sway/Wayland desktop, development tools, containers,
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

## Layout

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

`configuration.nix` assembles the modules. Hardware discovery is kept in
`hardware-configuration.nix`; services and feature groups live under
`modules/`.

## Usage

Check the flake:

```bash
nix flake check
```

Build or switch to the `forge` configuration:

```bash
sudo nixos-rebuild switch --flake .#forge
```

After rebuilding with Secure Boot enabled, verify and sign new EFI files with
`sbctl` as required by the local key setup.
