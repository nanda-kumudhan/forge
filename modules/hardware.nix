{ config, pkgs, ... }:

{
  # Intel graphics and media acceleration.
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  hardware.firmware = [ pkgs.sof-firmware ];

  # Scanner, Bluetooth, removable media, printing, and firmware services.
  hardware.sane.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input.General.ClassicBondedOnly = false;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  hardware.cpu.intel.updateMicrocode = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.upower.enable = true;
  services.flatpak.enable = true;
  services.fstrim.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "lz4";
  };
  boot.kernel.sysctl."vm.page-cluster" = 0;

  services.earlyoom = {
    enable = true;
    enableNotifications = true; # needs a notification daemon (e.g. mako)
    extraArgs = [
      "--avoid"
      "(^|/)(sway|systemd|Xwayland)$"
    ];
  };

  services.geoclue2.enable = true;
  # Enable BlueZ (Bluetooth daemon) to ensure A2DP/profile support via PipeWire

  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    IdleAction = "suspend";
    IdleActionSec = "15min";
  };

}
