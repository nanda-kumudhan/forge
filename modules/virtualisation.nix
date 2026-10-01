{ config, pkgs, ... }:

{
  # Container runtimes and hardware virtualization.
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
  programs.virt-manager.enable = true;

  systemd.services.waydroid-mount.wantedBy = [ "multi-user.target" ];

  # Netfilter modules, moved from boot.nix (Waydroid networking).
  boot.kernelModules = [
    "nf_tables"
    "nf_conntrack"
    "nf_nat"
    "nft_ct"
    "nft_chain_nat"
    "nft_masq"
  ];

  environment.systemPackages = with pkgs; [
    # Virtualization and containers.
    qemu
    spice-gtk
    distrobox
    podman-desktop
    docker-compose
    nftables
    dnsmasq

    # Kubernetes development stack.
    kubectl
    kind
    minikube
    kubernetes-helm
    kustomize
    k9s
    kubectx
  ];
}
