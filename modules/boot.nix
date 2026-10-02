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
      "lsm=landlock,yama,apparmor,bpf,lockdown"
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

  specialisation.latest-kernel.configuration = {
    system.nixos.tags = [ "Latest" ];
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  };
}
