{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = with pkgs; [
    nixd
    nixl
    nixfmt
    nixpkgs-fmt
  ];
}
