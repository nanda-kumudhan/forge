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
}
