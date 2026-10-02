{ pkgs, ... }:

{
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  environment.systemPackages = with pkgs; [ fuse2 ];

  services.envfs.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    bzip2
    openssl
    curl
    glib
    freetype
    dbus
    expat
    fontconfig
    libGL
    libdrm
    mesa
    nspr
    nss
    pango
    cairo
    atk
    gtk3
    alsa-lib
    pipewire
    wayland
    libxkbcommon
    libx11
    libxext
    libxcb
    libxcomposite
    libxdamage
    libxfixes
    libxrandr
    libxrender
    libxtst
  ];
}
