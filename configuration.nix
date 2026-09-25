{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "26.05";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "msr" "uinput" ];


  networking.hostName = "forge";
  
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-wireguard
    ];
  };
  
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

  

 
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  console.keyMap = "uk";
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };




  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      autotiling foot grim htop imv dunst mpv kanshi
      nwg-look brightnessctl bluetui
      pavucontrol polkit_gnome slurp swaybg swayidle
      swaylock thunar waybar wdisplays wf-recorder
      zathura playerctl rofi
      xarchiver
    ];
  };

 
 
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast = {
        chooser_type = "dmenu";
        chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu -p 'Select Output:'";
      };	    
  extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  config = {
    common = {
      default = [ "wlr" "gtk" ];
    };
    sway = {
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
    };
   };
  };


  hardware.graphics = {
    enable = true;
  };
  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.input.General.ClassicBondedOnly = false;


  security.polkit.enable = true;
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };
  security.rtkit.enable = true;
  security.apparmor.enable = true;
  security.apparmor.packages = [ pkgs.apparmor-profiles ];
  security.apparmor.killUnconfinedConfinables = true;


  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.upower.enable = true;
  services.flatpak.enable = true;
  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    IdleAction = "suspend";
    IdleActionSec = "15min";
  };


  virtualisation.podman = {
    enable = true;
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.waydroid.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    # Applications & Browsers
    anki
    brave
    firefox
    keepassxc
    libreoffice-fresh
    localsend
    telegram-desktop
    texstudio
    tor-browser

    # System & Hardware Utilities
    android-tools
    appimage-run
    bluez
    btrfs-progs
    cups-pk-helper
    efibootmgr
    exfatprogs
    fprintd
    fuse2
    fwupd
    gnome-disk-utility
    networkmanagerapplet
    ntfsprogs
    powertop
    proton-vpn-cli
    qemu
    qrencode
    remmina
    smartmontools
    snapper
    spice
    spice-gtk
    spice-protocol
    system-config-printer
    tor
    torsocks
    udiskie
    unrar
    unzip
    wget
    wmenu

    # Development Toolchains & Environment
    arduino-cli
    arduino-ide
    cargo
    clang
    cmake
    curl
    dbeaver-bin
    distrobox
    fastfetch
    gcc
    gdb
    gh
    git
    go
    gradle
    jq
    jdk
    jupyter
    lldb
    lswt
    maven
    nano
    neovim
    nodejs
    podman-desktop
    python3
    python3Packages.ipython
    python3Packages.pip
    python3Packages.pipx
    python3Packages.virtualenv
    rpi-imager
    ruby
    rustc
    seahorse
    texlive.combined.scheme-full
    transmission-gtk
    tree
    vim
    zed-editor

    # Styling, Themes & Icons
   
    materia-theme
    noto-fonts
    noto-fonts-color-emoji
    papirus-icon-theme
  ];


  programs.nix-ld.enable = true;
  services.dbus.enable = true;

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  users.users."builder" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "dialout" "adbusers" "input" "docker" ];
  };

  virtualisation.docker.enable = true;

  programs.starship.enable = true;

  services.fstrim.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.ly.enable = true;
  

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

 # 1. Disable power-profiles-daemon to eliminate backend scaling conflicts
  services.power-profiles-daemon.enable = false;

  # 2. Deploy TLP with the tlp-pd compatibility daemon wrapper
  services.tlp = {
    enable = true;
    pd.enable = true; # Enforces the power-profiles-daemon D-Bus shim layer
    
    settings = {
      # Automated profiles depending on hardware connection state
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Battery health metrics for your T490s soldered power cells
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}
