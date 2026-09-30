{
  description = "Forge - Stable 26.05 Secure NixOS Setup";

  inputs = {
    # Stable NixOS channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.forge = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Maps your Intel hardware structure
      modules = [
        # Loads your primary configuration settings
        ./configuration.nix
      ];
    };
  };
}
