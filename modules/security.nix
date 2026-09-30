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
  security.apparmor = {
    enable = true;
    packages = [ pkgs.apparmor-profiles ];
    killUnconfinedConfinables = true;
  };

  # Unlock the GNOME keyring through the Ly login session.
  security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.ly.fprintAuth = true;
  services.gnome.gnome-keyring.enable = true;
}
