{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "msr" "uinput" ];

  boot.initrd.luks.devices = {
    # Your Root Partition
    "luks-4aa2b9f3-6eb6-4442-a58e-1c98abc967bc" = {
      device = "/dev/disk/by-uuid/4aa2b9f3-6eb6-4442-a58e-1c98abc967bc";
      crypttabExtraOpts = [ "tpm2-device=auto" ];
    };
    # Your Swap Partition
    "luks-9f3b7c34-06ca-4c9d-91d8-64018e82263a" = {
      device = "/dev/disk/by-uuid/9f3b7c34-06ca-4c9d-91d8-64018e82263a";
      crypttabExtraOpts = [ "tpm2-device=auto" ];
    };
  };

  boot.resumeDevice = "/dev/mapper/luks-9f3b7c34-06ca-4c9d-91d8-64018e82263a";
  
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };  

  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "tpm_tis" ];

  specialisation = {
    latest-kernel.configuration = {
      system.nixos.tags = [ "latest-kernel" ];
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
