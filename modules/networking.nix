{ config, pkgs, ... }:

{
  # LocalSend uses this port for device discovery and file transfers.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

  # NetworkManager handles wired, wireless, and VPN connections.
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

  services.httpd.enable = true;
  #networking.nftables.enable = true;
}
