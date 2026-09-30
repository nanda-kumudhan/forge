{ config, pkgs, lib, ... }:

{
  # Use systemd-boot with manually managed Secure Boot signatures.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Restrict unsigned kernel-level modifications while retaining module loading.
  boot.kernelParams = [
    "lockdown=integrity" 
    "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
  ];

  boot.kernelModules = [ "msr" "uinput" ];

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
