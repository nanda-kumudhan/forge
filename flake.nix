{
  description = "Forge - Stable 26.05 Secure NixOS Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.forge = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
