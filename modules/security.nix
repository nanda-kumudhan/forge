{ pkgs, ... }:

{
  security = {
    polkit.enable = true;

    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };

    apparmor = {
      enable = true;
      packages = [ pkgs.apparmor-profiles ];
      killUnconfinedConfinables = true;
    };

    lsm = [ "lockdown" ];

    protectKernelImage = true;
    lockKernelModules = true;

    pam.services.ly.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
