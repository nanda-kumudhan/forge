{ pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
      checkReversePath = "loose";
    };

    nftables.enable = true;

    networkmanager = {
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
  };
}
