{
  description = "James' NixOS + Hyprland flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos-hypr = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit hyprland;
      };

      modules = [
        ./system/configuration.nix

        # Home Manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.james = import ./home/james.nix;
        }

        # Hyprland NixOS module using git package from the Hyprland flake
        {
          programs.hyprland = {
            enable = true;
            xwayland.enable = true;
            package = hyprland.packages.${system}.hyprland;
          };
        }
      ];
    };
  };
}
