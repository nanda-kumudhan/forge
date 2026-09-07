# forge — Deployable NixOS Workstation

 A deployable **NixOS 26.05** workstation configuration intended for quickly turning a compatible machine into a fully equipped development computer.

 The goal is simplicity: **no flakes, no Secure Boot configuration, and no unnecessary infrastructure**. The system provides a ready-to-use development environment with Sway, networking, VPN support, virtualization, containers, and common desktop applications.

 ## Philosophy

 This configuration is designed for situations where I need a computer and want to get productive quickly.

 Instead of manually installing and configuring:

 - Development tools
- Editors
- Compilers
- Programming languages
- Virtual machines
- Containers
- VPN clients
- Desktop applications
- Audio/Bluetooth support
- Sway and Wayland utilities

 they are all defined declaratively in one NixOS configuration.

 The system favors:

 - **NixOS stable** over Unstable
- **Latest available kernel** for newer hardware support
- **Sway/Wayland** as the primary desktop
- **Simple channel-based management** instead of flakes
- **Reproducible system configuration**
- **Useful development tooling out of the box**
- **Minimal boot/security complexity for now**

 ## System

 | Component | Configuration |
| --- | --- |
| OS | NixOS 26.05 |
| Architecture | x86\_64 |
| Target hardware | AMD TRIGKEY S5 |
| Kernel | `linuxPackages_latest` |
| Bootloader | systemd-boot |
| Secure Boot | Not configured |
| Desktop | Sway |
| Guest desktop | KDE Plasma 6 |
| Display manager | SDDM |
| Display protocol | Wayland |
| Networking | NetworkManager |
| Firewall | Enabled |
| VPN | OpenVPN + WireGuard |
| Audio | PipeWire |
| Containers | Podman + Docker |
| Virtual machines | KVM/libvirt |
| Android | Waydroid |
| Security | TPM2 + AppArmor + firewall |
| Nix flakes | Not used |

 ## Desktop

 ### Sway

 Sway is the primary desktop environment.

 The configuration includes a collection of Wayland tools and utilities:

 - Waybar
- Foot
- Rofi
- Dunst
- Grim
- Slurp
- Swaylock
- Swayidle
- Swaybg
- Kanshi
- Wdisplays
- wl-clipboard
- NetworkManager applet
- Blueman
- Pavucontrol
- Thunar
- Zathura
- MPV
- Playerctl

 The goal is to have a usable Sway environment immediately after deployment without manually assembling the basic Wayland ecosystem.

 ### KDE Plasma

 KDE Plasma 6 is also installed.

 It is primarily intended as a convenient desktop session for the `guest` account, while Sway is the preferred environment for the primary user.

 SDDM provides the graphical login screen and session selection.

 ## Development environment

 The system is intended to be ready for general software development immediately after installation.

 ### Languages and toolchains

 Included development environments include:

 - C
- C++
- Rust
- Go
- Ruby
- Java
- Python
- JavaScript/Node.js

 Also included:

 - GCC
- Clang
- GDB
- LLDB
- Cargo
- Maven
- Gradle
- JDK
- Python virtual environments
- pip
- IPython
- Jupyter

 ### Editors

 Installed editors include:

 - Neovim
- Vim
- Zed

 Git and common command-line utilities are also included.

 ### Database development

 DBeaver is included for working with databases.

 ## Virtualization

 The workstation includes both containers and full virtual machines.

 ### Podman

 Podman is enabled with Docker compatibility:

```
virtualisation.podman = {
  enable = true;
  dockerCompat = true;
};
```

 Podman Desktop is also installed.

 ### Docker

 Docker is enabled for compatibility with software that expects Docker.

 The primary user is a member of the `docker` group.

 > Membership of the Docker group provides effectively root-equivalent access to the system. Only trusted users should belong to it.

 ### KVM / libvirt

 KVM/libvirt and virt-manager are enabled for running virtual machines.

 SPICE USB redirection is also enabled.

 ### Waydroid

 Waydroid is enabled for running Android applications on the Linux desktop.

 ## Networking

 NetworkManager manages the system's network connections.

 The firewall is enabled:

```
networking.firewall.enable = true;
```

 Port `53317` is currently allowed for both TCP and UDP.

 If the port is not required by a deployed application, it should be removed from the firewall configuration.

 ## VPN

 The system supports common VPN configurations.

 ### OpenVPN

 OpenVPN and NetworkManager integration are installed:

```
networking.networkmanager = {
  enable = true;
  plugins = with pkgs; [
    networkmanager-openvpn
  ];
};
```

 The OpenVPN client is also installed.

 An `.ovpn` configuration can be imported with:

```
nmcli connection import type openvpn file your-vpn.ovpn
```

 ### WireGuard

 WireGuard tools are installed:

```
wireguard-tools
```

 NetworkManager provides native WireGuard connection support.

 A WireGuard configuration can be imported with:

```
nmcli connection import type wireguard file your-vpn.conf
```

 ## Security

 The system currently uses several basic security layers:

 - Firewall
- AppArmor
- Polkit
- TPM 2.0 support
- CPU microcode updates
- GNOME Keyring
- Normal NixOS privilege separation

 ### Secure Boot

 **Secure Boot is not currently configured.**

 The system currently uses standard `systemd-boot`:

```
boot.loader.systemd-boot.enable = true;
```

 Lanzaboote and `sbctl` are intentionally not part of the current deployment.

 Secure Boot may be added later.

 ### TPM

 TPM 2.0 support is enabled:

```
security.tpm2 = {
  enable = true;
  pkcs11.enable = true;
  tctiEnvironment.enable = true;
};
```

 Enabling TPM support does **not** automatically mean that the disk is encrypted or that the TPM is being used for disk unlocking.

 ### Disk encryption

 Disk encryption is installation/storage dependent and is not defined by the main configuration shown here.

 For machines that may be physically accessible to other people, LUKS2 disk encryption is recommended.

 Bluetooth, fingerprint readers, scanners, and other common workstation hardware are also supported where available.

 ## Audio

 PipeWire provides the audio stack:

```
services.pipewire = {
  enable = true;
  alsa.enable = true;
  pulse.enable = true;
  jack.enable = true;
};
```

 This provides compatibility with modern desktop applications while supporting ALSA, PulseAudio applications, and JACK workloads.

 ## Power management

 The system uses `power-profiles-daemon`.

 It is configured to suspend after 15 minutes of inactivity:

```
services.logind.settings.Login = {
  HandlePowerKey = "suspend";
  IdleAction = "suspend";
  IdleActionSec = "15min";
};
```

 SSD TRIM is enabled:

```
services.fstrim.enable = true;
```

 ZRAM is enabled at 50% of system memory:

```
zramSwap = {
  enable = true;
  memoryPercent = 50;
};
```

 ## Storage and Nix maintenance

 Automatic Nix store optimization is enabled:

```
nix.settings.auto-optimise-store = true;
nix.optimise.automatic = true;
```

 Automatic garbage collection is intentionally disabled.

 Garbage collection can be performed manually:

```
sudo nix-collect-garbage -d
```

 This is intentional for a deployable system where I may want to keep older generations around for rollback.

 ## Deployment

 This configuration deliberately does **not use flakes**.

 That keeps deployment straightforward and avoids introducing a `flake.nix`/`flake.lock` workflow when a normal NixOS configuration is sufficient.

 ### Test a configuration

 Before switching permanently:

```
sudo nixos-rebuild test
```

 ### Apply configuration

 For a channel-based installation:

```
sudo nixos-rebuild switch --upgrade
```

 This updates the configured NixOS channel and switches to the new system configuration.

 If the channel has already been updated:

```
sudo nixos-rebuild switch
```

 ## Rollbacks

 NixOS creates system generations when configurations are rebuilt.

 If a new deployment doesn't work correctly, reboot and select an older generation from `systemd-boot`.

 Installed generations can be inspected with:

```
sudo nix-env --list-generations \
  --profile /nix/var/nix/profiles/system
```

 This makes the machine relatively easy to recover after a bad configuration or package update.

 ## Kernel

 The system intentionally uses:

```
boot.kernelPackages = pkgs.linuxPackages_latest;
```

 This means the system uses the latest kernel package provided by the selected `nixpkgs` release.

 The operating system remains based on **NixOS 26.05 stable**; selecting `linuxPackages_latest` does not turn the system into NixOS Unstable.

 Check the currently running kernel:

```
uname -r
```

 ## Users

 ### Primary user

 The primary account is:

```
nanda-kumudhan
```

 It has administrative and development-related group membership, including:

```
networkmanager
wheel
libvirtd
kvm
dialout
adbusers
input
docker
```

 ### Guest user

 A separate `guest` account is provided for non-administrative use.

 The guest account only belongs to:

```
networkmanager
```

 It does not have administrative, Docker, KVM, or libvirt privileges.

 A real password should be configured before using the account.

 ## Desktop applications

 The system includes a broad collection of applications suitable for a general-purpose development workstation.

 Notable applications include:

 - Firefox
- Brave
- Anki
- LibreOffice
- KeepassXC
- DBeaver
- Remmina
- Spotify
- Zed
- Neovim
- Git
- Jupyter
- Texmaker
- Texstudio
- virt-manager
- Podman Desktop
- QEMU
- rpi-imager
- Seahorse
- GNOME Disk Utility

 ## Firmware

 `fwupd` is intentionally **not enabled**.

 Firmware/BIOS updates for the target TRIGKEY hardware are handled separately rather than through the NixOS configuration.

 ## Current boot/security status

 The current deployment intentionally keeps boot configuration simple:

```
UEFI
  │
  └── systemd-boot
        │
        └── NixOS
```

 There is currently:

 - No Secure Boot
- No Lanzaboote
- No `sbctl`
- No custom Secure Boot keys

 These can be added later if the threat model or deployment requirements change.

 ## Why this configuration exists

 This isn't intended to be a minimal NixOS installation.

 It is a **ready-to-deploy workstation**.

 The idea is that when I need a computer for development, I should be able to deploy this configuration and immediately have:

```
NixOS
 ├── Sway
 ├── Wayland tools
 ├── Development toolchains
 ├── Git
 ├── Editors
 ├── Python / Jupyter
 ├── Java / Maven / Gradle
 ├── C / C++ / Rust / Go / Ruby
 ├── Containers
 ├── Virtual machines
 ├── Android / Waydroid
 ├── OpenVPN
 ├── WireGuard
 ├── PipeWire
 ├── Bluetooth
 ├── Firewall
 └── Common desktop applications
```

 The configuration favors **practicality and fast deployment** over having the smallest possible system.

 ## Design goals

 1. **Deployable** — usable as a general-purpose workstation configuration.
2. **Simple** — no flakes or unnecessary infrastructure.
3. **Stable** — based on NixOS 26.05 rather than Unstable.
4. **Modern** — uses the latest kernel available in the selected nixpkgs.
5. **Developer-friendly** — broad language and tooling support.
6. **Wayland-first** — Sway is the primary desktop.
7. **Virtualization-ready** — KVM, libvirt, Podman, Docker and Waydroid.
8. **Network-ready** — NetworkManager, firewall, OpenVPN and WireGuard.
9. **Recoverable** — NixOS generations provide straightforward rollback.
10. **Extensible** — Secure Boot, additional VPNs, encryption, and other features can be added later.
