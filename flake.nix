{
  description = "Forge - Stable 26.05 Secure NixOS Setup";

  inputs = {
    # 1. Targets the bleeding-edge NixOS unstable channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # 2. Pulls Lanzaboote and forces it to use your unstable packages 
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lanzaboote, ... }@inputs: {
    nixosConfigurations.forge = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Maps your Intel hardware structure
      modules = [
        # Injects Lanzaboote system-wide
        lanzaboote.nixosModules.lanzaboote

        # Loads your primary configuration settings
        ./configuration.nix
      ];
    };
  };
}
