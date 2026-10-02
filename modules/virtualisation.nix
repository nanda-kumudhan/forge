{ pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    podman.enable = true;
    docker.enable = true;

    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };

    spiceUSBRedirection.enable = true;

    waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
  };

  programs.virt-manager.enable = true;

  systemd.services.waydroid-mount.wantedBy = [ "multi-user.target" ];

  boot.kernelModules = [
    "nf_conntrack"
    "nf_nat"
    "nf_tables"
    "nft_chain_nat"
    "nft_ct"
    "nft_masq"
  ];

  environment.systemPackages = with pkgs; [
    distrobox
    docker-compose
    dnsmasq
    nftables
    podman-desktop
    qemu
    spice-gtk

    k9s
    kind
    kustomize
    kubectl
    kubectx
    kubernetes-helm
    minikube
  ];
}
