{ config, pkgs, ... }:

{
  # Desktop authorization and privileged helper policy.
  security.polkit.enable = true;

  # TPM2 support for disk unlocking and hardware-backed credentials.
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  # Realtime audio scheduling and mandatory access control.
  security.rtkit.enable = true;
  security.apparmor.enable = true;
  security.apparmor = {
    packages = [ pkgs.apparmor-profiles ];
    killUnconfinedConfinables = true;
  };

  # Unlock the GNOME keyring through the Ly login session.
  security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.ly.fprintAuth = true;
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
  
  security.protectKernelImage = true;
  security.lockKernelModules = true;

}
