{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Use systemd-boot with manually managed Secure Boot signatures.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Restrict unsigned kernel-level modifications while retaining module loading.
  boot.kernelParams = [
    "lockdown=integrity"
    "lsm=landlock,yama,apparmor,bpf,lockdown"
  ];
  boot.kernelModules = [
    "msr"
    "uinput"
    "dummy"
    "wireguard"
  ];
  # Use systemd in the initrd so TPM and encrypted-volume activation are
  # handled by the same service manager as the running system.
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "tpm_tis" ];

  # The Latest kernel is the default; the LTS kernel remains available from
  # the systemd-boot specialisation menu.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  specialisation.lts-kernel.configuration = {
    system.nixos.tags = [ "LTS" ];
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
  };
}
