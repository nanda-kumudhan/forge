{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Load all modular sub-files directly here
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/security.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/packages.nix
  ];

  system.stateVersion = "26.05";
  networking.hostName = "forge";

  # Localization and Regional Formatting
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

  nixpkgs.config.allowUnfree = true; 
  services.dbus.enable = true;

  # Account Profile
  users.users."builder" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "dialout" "adbusers" "input" "docker" ];
  };

  # Environments, Shells & Global Runtimes
  programs.nix-ld.enable = true;
  programs.starship.enable = true;
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  # Universal Styling Assets
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
