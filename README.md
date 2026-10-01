# NixOS Configuration

A stable, secure NixOS development environment for developers and CS students. Built with reliable stable channels—no experimental nonsense—designed to work seamlessly with Sway.

## Overview

This repository contains a complete NixOS system configuration with modular organization for easy maintenance and customization.

![Desktop](assets/desktop.png)

## System Information

- **Hostname**: forge
- **State Version**: 26.05
- **Timezone**: Europe/London
- **Locale**: en_GB.UTF-8

## Configuration Structure

The configuration is organized into the following modules:

- **`boot.nix`** - Boot and bootloader configuration
- **`desktop.nix`** - Desktop environment setup
- **`hardware.nix`** - Hardware-specific settings
- **`laptop.nix`** - ThinkPad T490s power management (TLP), fingerprint login, battery thresholds
- **`networking.nix`** - Network configuration
- **`packages.nix`** - System packages and software
- **`security.nix`** - Security settings and policies
- **`virtualisation.nix`** - Virtualisation and container setup

## Features

- **Stable Channels** - Built on reliable NixOS stable channels, no flakes or experimental features
- Secure and hardened configuration for safe development
- Modular structure for easy maintenance and customization
- Designed and optimized for Sway window manager
- Comprehensive development tools and environment

## Getting Started

To apply this configuration to your NixOS system:

```bash
nixos-rebuild switch -I nixos-config=./configuration.nix
```

## Files

- `configuration.nix` - Main system configuration
- `hardware-configuration.nix` - Hardware-specific settings
- `modules/` - Modular configuration files

---

Made with NixOS ❄️
