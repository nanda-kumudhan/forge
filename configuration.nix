{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/compat.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/laptop.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/security.nix
    ./modules/virtualisation.nix
  ];

  system.stateVersion = "26.05";
  networking.hostName = "forge";

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  services.xserver.xkb.layout = "gb";

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
      "docker"
    ];
  };
}
