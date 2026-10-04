{ pkgs, lib, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages;

    kernelParams = [
      "lockdown=integrity"
    ];

    kernelModules = [
      "msr"
      "uinput"
      "dummy"
      "wireguard"
    ];

    initrd = {
      systemd.enable = true;
      availableKernelModules = [ "tpm_tis" ];
    };

  };

  specialisation = {
      latest.configuration = {

        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

        system.nixos.tags = [ "latest-kernel" ];
      };
    };

}
