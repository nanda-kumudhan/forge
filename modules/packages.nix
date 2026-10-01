{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # Applications and command-line tools that are not configured as services.
  environment.systemPackages = with pkgs; [
    # Core utilities and archives.
    p7zip
    unrar
    unzip
    wget
    tree
    fastfetch
    jq
    dmidecode
    fuse2
    android-tools
    wl-clipboard
    qrencode
    man-db
    man-pages
    cups-pk-helper

    # Fonts and themes.
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    noto-fonts
    noto-fonts-color-emoji
    dejavu_fonts
    liberation_ttf
    materia-theme

    # File management and desktop utilities.
    udiskie
    gnome-disk-utility
    seahorse
    xdg-utils
    btrfs-progs
    dosfstools
    exfatprogs
    ntfs3g
    ntfsprogs-plus

    # Browsers, messaging, file sharing, and VPN tools.
    firefox
    brave
    discord
    telegram-desktop
    localsend
    prismlauncher
    transmission_4-gtk
    tor-browser
    openconnect
    proton-vpn-cli
    wireguard-tools
    remmina
    spotify

    # Maintenance, firmware, and Secure Boot tools.
    fwupd
    keepassxc
    gcr
    powertop
    smartmontools
    efibootmgr
    sbctl
    tpm2-tools
    torsocks
    system-config-printer

    # Programming languages, build tools, and embedded tooling.
    git
    gh
    dbeaver-bin
    arduino-ide
    arduino-cli
    rpi-imager
    github-copilot-cli
    nil
    nixd

    # Editors, media, office, and document tools.
    nano
    helix
    vim
    neovim
    zed-editor

    libreoffice-fresh
    anki
    texstudio
    texlive.combined.scheme-full
    networkmanagerapplet
  ];
}
