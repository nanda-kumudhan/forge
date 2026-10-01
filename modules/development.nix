{ config, pkgs, ... }:

{
  # Per-project shells load automatically when entering a project directory.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Host-wide toolchains. Hosts that import this get them permanently.
  environment.systemPackages = with pkgs; [

    nixd
    nil

    # C/C++ toolchain and build systems.
    gcc
    clang
    gnumake
    cmake
    pkg-config
    autoconf
    automake
    gdb
    lldb

    # Other languages.
    go
    ruby
    rustc
    cargo
    jdk
    maven
    gradle

    # Python and extras.
    python3
    python3Packages.pip
    python3Packages.pipx
    python3Packages.virtualenv
    python3Packages.jupyterlab
  ];
}
