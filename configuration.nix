{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ############################################################
  # Boot
  ############################################################
  system.stateVersion = "26.05";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "msr" "uinput" ];

 ############################################################
  # Networking
  ############################################################
  networking.hostName = "forge";
  
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };
  
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

  # tailscale removed

  ############################################################
  # Localization
  ############################################################
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

  ############################################################
  # Desktop Environments
  #
  # NOTE (read before relying on this): NixOS installs desktop
  # packages system-wide - there is no built-in way to say
  # "user A can only ever get Sway" and "user B can only ever
  # get KDE" at the package level. Both sessions will be
  # installed and SDDM will list both session types for
  # whoever's at the login screen. What you *can* enforce is
  # which session each account launches by default / is
  # expected to use - true per-user lockdown would need extra
  # work (e.g. PAM session restrictions or a wrapped session
  # script). This config sets it up so you log in as
  # nanda-kumudhan -> Sway, guest -> Plasma, but either account
  # could technically pick the other session from the SDDM menu.
  ############################################################

  # Sway - primary session, intended for nanda-kumudhan
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      autotiling foot grim htop imv dunst mpv kanshi
      nwg-look brightnessctl
      pavucontrol polkit_gnome slurp swaybg swayidle
      swaylock thunar waybar wdisplays wf-recorder
      zathura playerctl rofi
      xarchiver
    ];
  };

 
  ############################################################
  # Desktop Portals (screen sharing, file pickers)
  ############################################################
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast = {
        output_name = "eDP-1";
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

  ############################################################
  # Hardware
  ############################################################
  hardware.graphics = {
    enable = true;
  };
  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.input.General.ClassicBondedOnly = false;

  ############################################################
  # Security
  ############################################################
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

  ############################################################
  # Services
  ############################################################
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.blueman.enable = true;
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

  ############################################################
  # Virtualisation
  ############################################################
  virtualisation.podman = {
    enable = true;
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.waydroid.enable = true;
  programs.virt-manager.enable = true;

  ############################################################
  # Environment
  ############################################################
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # from the original nixos-config list
    anki brave gh firefox efibootmgr fprintd bluez
    cargo curl distrobox github-copilot-cli spice spice-gtk spice-protocol
    fastfetch gcc git gdb jq jupyter keepassxc libreoffice-fresh
    localsend lswt nano nodejs seahorse materia-theme
    papirus-icon-theme python3 qemu openvpn wireguard-tools
    remmina rustc rpi-imager tree wget zed-editor
    gruvbox-dark-gtk python3Packages.ipython python3Packages.pip
    python3Packages.virtualenv maven gradle jdk gnome-disk-utility
    arduino-ide arduino-cli appimage-run
    # merged in from the archway pkglists (pacman + aur), minus
    # vpn / tor / games / torrent apps, discord, and sbctl
    clang go ruby vim neovim lldb transmission_4
    dbeaver-bin podman-desktop cmake
    cups-pk-helper system-config-printer
    exfatprogs ntfsprogs btrfs-progs fuse2
    powertop smartmontools snapper proton-vpn-cli
    noto-fonts noto-fonts-color-emoji torsocks
    udiskie wmenu tor tor-browser
    texlive.combined.scheme-full texstudio
  ];

  programs.nix-ld.enable = true;
  services.dbus.enable = true;

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  ############################################################
  # Users
  ############################################################
  users.users."builder" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "dialout" "adbusers" "input" "docker" ];
  };

  virtualisation.docker.enable = true;

  programs.starship.enable = true;

  ############################################################
  # Display Manager
  #
  # Swapped greetd/tuigreet (which just launched straight into
  # Sway for anyone) for SDDM, since we now need a session
  # picker so nanda-kumudhan can choose Sway and uest can
  # choose Plasma at login.
  ############################################################

  ############################################################
  # Laptop Power Management
  ############################################################
  services.power-profiles-daemon.enable = true;

  services.fstrim.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.ly.enable = true;
  
  # nix.gc block removed - no automatic garbage collection

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
}
