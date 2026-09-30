{ config, pkgs, lib, ... }:

{
  # Use systemd-boot with manually managed Secure Boot signatures.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Restrict unsigned kernel-level modifications while retaining module loading.
  boot.kernelParams = [ "lockdown=integrity" ];
  boot.kernelModules = [ "msr" "uinput" ];

  # TPM-backed unlocking for the encrypted root and swap volumes.
  boot.initrd.luks.devices = {
    "luks-4aa2b9f3-6eb6-4442-a58e-1c98abc967bc" = {
      device = "/dev/disk/by-uuid/4aa2b9f3-6eb6-4442-a58e-1c98abc967bc";
      crypttabExtraOpts = [ "tpm2-device=auto" ];
    };

    "luks-9f3b7c34-06ca-4c9d-91d8-64018e82263a" = {
      device = "/dev/disk/by-uuid/9f3b7c34-06ca-4c9d-91d8-64018e82263a";
      crypttabExtraOpts = [ "tpm2-device=auto" ];
    };
  };

  boot.resumeDevice = "/dev/mapper/luks-9f3b7c34-06ca-4c9d-91d8-64018e82263a";

  # Use systemd in the initrd so TPM and encrypted-volume activation are
  # handled by the same service manager as the running system.
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "tpm_tis" ];

  # The LTS kernel is the default; the newer kernel remains available from
  # the systemd-boot specialisation menu.
  boot.kernelPackages = pkgs.linuxPackages;
  specialisation.latest-kernel.configuration = {
    system.nixos.tags = [ "Latest" ];
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  };
}
