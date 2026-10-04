{ pkgs, ... }:

{

  programs.nix-ld.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.envfs.enable = true;
  services.flatpak.enable = true;

}
