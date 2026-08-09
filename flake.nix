{
  description = "Liam's MacBook Air - Nix Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

    outputs = {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      ...
    }: {
        darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
            specialArgs = {
                inherit self;
            };
            modules = [
                ./configuration.nix

                home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.liam = import ./home.nix;
                    home-manager.extraSpecialArgs = { };
                }

                nix-homebrew.darwinModules.nix-homebrew
                {
                    nix-homebrew = {
                        enable = true;
                        user = "liam";
                        taps = {
                            "homebrew/homebrew-core" = homebrew-core;
                            "homebrew/homebrew-cask" = homebrew-cask;
                        };
                        mutableTaps = false;
                    };
                }
                ({ config, ... }: {
                    homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
                })
            ];
        };
    };
}
