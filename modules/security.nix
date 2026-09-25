{ config, pkgs, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

   # Global Network Setup
  networking.networkmanager = {
    enable = true;
    wifi = {
      macAddress = "stable-ssid";
      scanRandMacAddress = true;
    };
    ethernet.macAddress = "stable-ssid";
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-openconnect
    ];
  };

  security.polkit.enable = true;
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };
  
  security.rtkit.enable = true;
  security.apparmor = {
    enable = true;
    packages = [ pkgs.apparmor-profiles ];
    killUnconfinedConfinables = true;
  };

  security.pam.services.ly.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
}
