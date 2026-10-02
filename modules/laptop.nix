{ ... }:

{
  security.pam.services.ly.fprintAuth = true;

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  services.fprintd.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;
}
