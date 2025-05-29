{
  description = "NixOS with gaming, graphics, and dev profiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: let
  system = "x86_64-linux";
  vars = import ./variables.nix;
  in {
    nixosConfigurations = {
      gaming = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/gaming/configuration.nix
        ];
      };

      graphics = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/graphics/configuration.nix
        ];
      };

      dev = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/dev/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      gaming = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          { home.username = vars.username; home.homeDirectory = vars.homeDirectory; }
          ./hosts/gaming/home.nix
        ];
      };

      graphics = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          { home.username = vars.username; home.homeDirectory = vars.homeDirectory; }
          ./hosts/graphics/home.nix
        ];
      };

      dev = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          { home.username = vars.username; home.homeDirectory = vars.homeDirectory; }
          ./hosts/dev/home.nix
        ];
      };
    };
  };
}
