# NixOS Configuration — forge

A stable, secure NixOS development environment for developers and CS students. Built on reliable stable channels—no flakes or experimental features—and optimised for a Sway-based Wayland desktop.

## Desktop

![Desktop](assets/desktop.png)

## System Information

| Key | Value |
|---|---|
| **Hostname** | `forge` |
| **NixOS release** | 26.05 (stable) |
| **Kernel** | `linuxPackages` (LTS, default); `linuxPackages_latest` via boot menu |
| **Timezone** | `Europe/London` |
| **Locale** | `en_GB.UTF-8` |
| **CPU** | Intel |
| **Window manager** | Sway (Wayland) |
| **Display manager** | Ly |
| **Audio** | PipeWire (ALSA / PulseAudio / JACK compat) |

## Module Structure

| Module | Description |
|---|---|
| `boot.nix` | systemd-boot, kernel lockdown, LSM stack (Landlock, Yama, AppArmor, BPF), LTS kernel + latest specialisation |
| `desktop.nix` | Sway, Waybar, Foot, Rofi, Dunst, XDG portals, PipeWire, Blueman, Ly |
| `hardware.nix` | Intel graphics & media, SOF firmware, Bluetooth, printing, Flatpak, zram, earlyoom |
| `laptop.nix` | TLP (75–80 % battery thresholds), CPU governor profiles, fingerprint login, thermald |
| `networking.nix` | NetworkManager, MAC randomisation, nftables, OpenVPN / OpenConnect, LocalSend |
| `security.nix` | Polkit, TPM2, AppArmor (with profiles), GNOME Keyring, kernel image & module locking |
| `virtualisation.nix` | Docker, Podman, libvirtd / QEMU-KVM, Waydroid, virt-manager, Kubernetes stack |
| `compat.nix` | AppImage (binfmt), envfs, nix-ld with broad library set for unpatched binaries |
| `guest.nix` | Optional KDE Plasma 6 guest session — tmpfs home wiped on logout *(not loaded by default)* |

## Features

### Security & Boot
- **Secure Boot ready** — managed with `sbctl` and `tpm2-tools`; TPM2 PKCS11 available for disk unlock
- **Kernel lockdown** (`integrity` mode) with a full LSM stack: Landlock → Yama → AppArmor → BPF → Lockdown
- **AppArmor** with upstream profiles and `killUnconfinedConfinables = true`
- **Kernel image protection** and module locking enabled
- **systemd-initrd** for consistent TPM + encrypted-volume handling at boot

### Laptop Power Management
- **TLP** replaces `power-profiles-daemon` — performance on AC, powersave on battery
- **Battery charge thresholds**: starts at 75 %, stops at 80 %
- **Fingerprint login** via `fprintd` on the Ly PAM stack
- **Thermald** for proactive thermal management

### Networking & Privacy
- NetworkManager with **stable-SSID MAC randomisation** on both Wi-Fi and Ethernet
- **nftables** firewall; reverse-path filtering set to `loose` for VPN compatibility
- OpenVPN and OpenConnect NetworkManager plugins built-in
- **ProtonVPN CLI**, **WireGuard**, **Tor Browser**, and **torsocks** included

### Desktop (Sway / Wayland)
- **Autotiling**, **Kanshi** (display profiles), **wf-recorder** (screen recording)
- **Grim + Slurp** for screenshots; rofi as application launcher and dmenu replacement
- **XDG desktop portals** (wlr + GTK) for screenshot and screencast integration
- **Swaylock / Swayidle** for locking and idle management
- **Dunst** notifications, **Waybar** status bar, **Foot** terminal
- **PipeWire** with full ALSA, PulseAudio, and JACK compatibility

### Hardware
- **Intel VA-API** hardware video acceleration via `intel-media-driver`
- **zram** swap (50 %, lz4) with `vm.page-cluster = 0` for low-latency swapping
- **earlyoom** OOM prevention (protects Sway / systemd from being killed)
- **Bluetooth** with experimental features enabled (A2DP, battery reporting)
- SANE scanning, CUPS printing, Avahi mDNS, Flatpak, udisks2, and GVfs

### Virtualisation & Containers
- **Docker** and **Podman** (with `podman-desktop` and `distrobox`)
- **libvirtd + QEMU KVM** with virt-manager and SPICE USB redirection
- **Waydroid** (Android in a container, nftables variant)
- **Kubernetes dev stack**: `kubectl`, `kind`, `minikube`, `helm`, `kustomize`, `k9s`, `kubectx`

### Development Tooling
- **Editors**: Zed, Neovim, Helix, Vim, Nano
- **LSP / formatters**: `nixd`, `nixfmt`, `bash-language-server`, `marksman`
- **Git tooling**: `git`, `gh`, `github-copilot-cli`
- **Android**: Android Studio, `android-tools` (ADB/fastboot), Android toolchain
- **Embedded / IoT**: Arduino IDE, Arduino CLI, Raspberry Pi Imager
- **Database**: DBeaver
- **Shell**: Starship prompt, Direnv + nix-direnv, nix-ld (run unpatched binaries)
- **AppImage** support via binfmt + envfs

### Applications
| Category | Applications |
|---|---|
| **Browsers** | Firefox, Brave, Tor Browser |
| **Communication** | Discord, Telegram, Remmina |
| **File sharing** | LocalSend, Transmission 4 (GTK) |
| **Productivity** | LibreOffice, AnkI, TeXStudio + full TeX Live |
| **Media** | Spotify, MPV, Imv, Zathura |
| **Gaming** | PrismLauncher |
| **Security** | KeePassXC, GCR/Seahorse |
| **System** | fastfetch, powertop, smartmontools, fwupd, btop/htop |

## Getting Started

Clone the repository and apply the configuration to your NixOS system:

```bash
git clone https://github.com/<your-username>/forge.git
cd forge
sudo nixos-rebuild switch -I nixos-config=./configuration.nix
```

> **Note**: `hardware-configuration.nix` is machine-specific. Generate your own with `nixos-generate-config` and replace the existing file before switching.

## Optional: Guest Mode

`modules/guest.nix` provides an isolated KDE Plasma 6 guest session:

- Home directory is a **tmpfs** (2 GB, `nosuid`, `nodev`) wiped on every logout
- SDDM autologins the `guest` user at boot (replaces Ly)
- Empty password allowed for the guest account only
- KDE applications included: Ark, Elisa, Gwenview, Kate, KCalc, KDEConnect, Okular, Spectacle

To enable, add it to `imports` in `configuration.nix`:

```nix
imports = [
  # ... existing modules ...
  ./modules/guest.nix
];
```

## Files

```
forge/
├── configuration.nix           # Top-level system configuration
├── hardware-configuration.nix  # Machine-specific hardware settings
└── modules/
    ├── boot.nix                # Boot, kernel, and Secure Boot
    ├── compat.nix              # AppImage, envfs, nix-ld
    ├── desktop.nix             # Sway, PipeWire, display manager
    ├── guest.nix               # Optional KDE Plasma guest session
    ├── hardware.nix            # Drivers, printing, Bluetooth, zram
    ├── laptop.nix              # TLP, fingerprint, thermald
    ├── networking.nix          # NetworkManager, firewall, VPN
    ├── packages.nix            # System-wide packages
    ├── security.nix            # AppArmor, TPM2, polkit, keyring
    └── virtualisation.nix      # Docker, Podman, KVM, Waydroid, k8s
```

---

Made with NixOS ❄️
