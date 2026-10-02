{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib
      atk
      bzip2
      cairo
      curl
      dbus
      expat
      fontconfig
      freetype
      glib
      gtk3
      libdrm
      libGL
      libxcb
      libxcomposite
      libxdamage
      libxfixes
      libxkbcommon
      libxrandr
      libxrender
      libxtst
      libx11
      libxext
      mesa
      nspr
      nss
      openssl
      pango
      pipewire
      stdenv.cc.cc
      wayland
      zlib
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.starship.enable = true;

  services.envfs.enable = true;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [ fuse2 ];
}
