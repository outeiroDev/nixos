{
  description = "NixOS with Niri and Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    secrets = "/etc/nixos/secrets";
  in {
    nixosConfigurations = {
      home = nixpkgs.lib.nixosSystem {
	specialArgs = { inherit secrets; };
        modules = [
          ./hosts/home
          ./users/joel/default.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.joel = import ./users/joel/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
