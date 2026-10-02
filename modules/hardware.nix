{ pkgs, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
      ];
    };

    firmware = [ pkgs.sof-firmware ];
    cpu.intel.updateMicrocode = true;
    sane.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      input.General.ClassicBondedOnly = false;
      settings.General.Experimental = true;
    };
  };

  services.udisks2.enable = true;
  services.printing.enable = true;
  services.fstrim.enable = true;
  services.geoclue2.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "lz4";
  };

  boot.kernel.sysctl."vm.page-cluster" = 0;
}
