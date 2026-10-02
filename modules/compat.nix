{ pkgs, ... }:

{
  # envfs mounts /usr/bin, /bin, /sbin via FUSE so scripts with hardcoded
  # paths (e.g. #!/usr/bin/python, #!/usr/bin/env bash) work out of the box.
  services.envfs.enable = true;

  # Libraries exposed to unpatched ELF binaries through nix-ld.
  # nix-ld itself is enabled in configuration.nix.
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc # libstdc++, libgcc_s
    zlib
    bzip2
    openssl
    curl
    glib
    dbus
    expat
    fontconfig
    freetype
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
