{ ... }:

{
  security.pam.services.ly.fprintAuth = true;

  services.power-profiles-daemon.enable = false;

  hardware.cpu.intel.updateMicrocode = true;

  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  services.fprintd.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;
}
