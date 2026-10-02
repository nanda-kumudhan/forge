{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    p7zip
    unrar
    unzip
    wget
    tree
    fastfetch
    jq
    dmidecode
    android-tools
    wl-clipboard
    qrencode
    man-db
    man-pages
    cups-pk-helper

    papirus-icon-theme
    noto-fonts
    noto-fonts-color-emoji
    dejavu_fonts
    liberation_ttf
    materia-theme

    udiskie
    blueman
    gnome-disk-utility
    seahorse
    xdg-utils
    btrfs-progs
    dosfstools
    exfatprogs
    ntfs3g
    ntfsprogs-plus

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

    nixd
    nixfmt
    bash-language-server
    marksman
    git
    gh
    dbeaver-bin
    android-studio
    arduino-ide
    arduino-cli
    rpi-imager
    github-copilot-cli

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
