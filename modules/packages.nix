{ pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    p7zip
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
    localsend
    prismlauncher
    transmission_4-gtk
    tor-browser
    openconnect
    proton-vpn-cli
    wireguard-tools
    remmina

    fwupd
    keepassxc
    gcr_4
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
    pandoc
    git
    gh
    github-copilot-cli
    dbeaver-bin

    nano
    helix
    vim
    neovim
    zed-editor

    libreoffice
    anki
    texstudio
    texliveMedium
    networkmanagerapplet
  ];

}
