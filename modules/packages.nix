{ config, pkgs, ... }:

{
  # Applications and command-line tools that are not configured as services.
  environment.systemPackages = with pkgs; [
    # Core utilities and archives.
    p7zip
    unrar
    unzip
    xarchiver
    wget
    tree
    fastfetch
    jq
    cowsay
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
    thunar
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
    blueman
    bluez-tools
    discord
    telegram-desktop
    localsend
    prismlauncher
    transmission_4-gtk
    tor-browser
    openconnect
    networkmanager-openconnect
    proton-vpn-cli
    remmina
    spotify
    
    # Maintenance, firmware, and Secure Boot tools.
    fwupd
    keepassxc
    gnome-keyring
    libgnome-keyring
    polkit_gnome
    gcr
    libayatana-indicator
    powertop
    snapper
    smartmontools
    efibootmgr
    sbctl
    tpm2-tools
    torsocks
    fprintd
    system-config-printer
    zram-generator

    # Virtualization and containers.
    qemu
    systemdUkify
    spice-gtk
    distrobox
    podman-desktop
    docker-compose
    waydroid-helper

    # Kubernetes development stack.
    kubectl
    kind
    minikube
    kubernetes-helm
    kustomize
    k9s
    kubectx

    # Programming languages, build tools, and embedded tooling.
    gcc
    clang
    gnumake
    cmake
    pkg-config
    autoconf
    automake
    gdb
    lldb
    git
    gh
    go
    ruby
    rustc
    cargo
    jdk
    maven
    gradle
    dbeaver-bin
    nano
    nix
    python3
    python3Packages.pip
    python3Packages.pipx
    python3Packages.virtualenv
    python3Packages.jupyterlab
    arduino-ide
    arduino-cli
    rpi-imager
    github-copilot-cli    

    # Editors, media, office, and document tools.
    helix
    wmenu
    vim
    neovim
    zed-editor
    imv
    mpv
    zathura
    zathuraPkgs.zathura_pdf_poppler
    libreoffice-fresh
    anki
    texstudio
    texlive.combined.scheme-full
    gst_all_1.gst-plugins-good
    wireplumber
    wpa_supplicant
    networkmanagerapplet
  ];
}
