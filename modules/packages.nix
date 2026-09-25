{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core Utilities & Archives
    p7zip unrar unzip xarchiver wget tree fastfetch jq
    
    # Fonts & Themes
    nerd-fonts.jetbrains-mono papirus-icon-theme noto-fonts noto-fonts-color-emoji

    # File Managers & Desktops
    thunar udiskie gnome-disk-utility seahorse xdg-utils
    
    # Internet, VPN & Networks
    firefox telegram-desktop transmission_4-gtk tor-browser openconnect networkmanager-openconnect proton-vpn-cli
    
    # Maintenance Tools
    fwupd keepassxc powertop snapper smartmontools efibootmgr sbctl
    
    # Virtualisation & Containers
    qemu spice-gtk distrobox podman-desktop
    
    # Kubernetes Development Stack
    kubectl kind minikube kubernetes-helm kustomize k9s kubectx

    # Computer Science Programming Toolchains
    gcc clang cmake gdb lldb git gh go ruby rustc cargo jdk maven gradle dbeaver-bin
    python3 python3Packages.pip python3Packages.pipx arduino-ide arduino-cli rpi-imager
    
    # Editors, Readers & Document Systems
    vim neovim zed-editor imv mpv zathura libreoffice-fresh anki texstudio texlive.combined.scheme-full
  ];
}
