{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/security.nix
  ];

  # Keep this aligned with the NixOS release used to create the system.
  system.stateVersion = "26.05";
  networking.hostName = "forge";

  # Locale and keyboard configuration.
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

  # Several desktop applications and drivers are unfree.
  nixpkgs.config.allowUnfree = true;
  services.dbus.enable = true;

  # Primary local account.
  users.users.builder = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
      "dialout"
      "adbusers"
      "input"
      # Docker uses this group for access to its Unix socket. Rootless Podman
      # and Kubernetes do not require dedicated supplementary groups.
      "docker"
    ];
  };

  # Development and shell conveniences.
  programs.nix-ld.enable = true;
  programs.starship.enable = true;
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  # Fonts shared by the desktop and applications.
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
