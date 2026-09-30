{
	description = "Forge - Stable NixOS dev config for sway wm";

        inputs = {
  		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

 	};
	outputs = {  self, nixpkgs  }@inputs:  {
		
		nixosConfigurations.forge = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hardware-configuration.nix
				./configuration.nix
			];
		};
	};
}
