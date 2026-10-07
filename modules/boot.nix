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

    kernelPatches = [ {
      name = "enable-lockdown";
      patch = null;
      extraConfig = ''
        SECURITY_LOCKDOWN_LSM y
      '';
    } ];

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

}
