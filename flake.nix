{
  description = "NixOS with Niri and Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
     
    agenix.url = "github:ryantm/agenix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, agenix, home-manager, split-monitor-workspaces, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      home = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit agenix; };
        modules = [
          # Host configuration
          ./hosts/home

          # Secrets (agenix)
          agenix.nixosModules.default
          ./secrets

          # User: joel (NixOS-level)
          ./users/joel/default.nix
          ./users/joel/packages.nix
          ./users/joel/fonts.nix
          ./users/joel/shell.nix

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
