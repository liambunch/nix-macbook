{
  description = "Liam's MacBook Air - Nix Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = { nixpkgs, nix-darwin, home-manager, nix-homebrew, ... }:
    let
      system = "aarch64-darwin";
    in
    {
      darwinConfigurations.macbook =
        nix-darwin.lib.darwinSystem {
          inherit system;

          modules = [
            ./configuration.nix
            home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.liam = import ./home.nix;
              }
            nix-homebrew.darwinModules.nix-homebrew
              {
                nix-homebrew = {
                  enable = true;
                  user = "liam";
                  mutableTaps = false;
                };
              }
          ];
        };
    };
}