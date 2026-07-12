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

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    ...
  }:
  let
    system = "aarch64-darwin";
  in
  {
    darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
      inherit system;

      modules = [
        ({ pkgs, ... }: {
 	  system.stateVersion = 6;

    system.defaults = {
      dock = {
        autohide = false;
        show-recents = false;
        tilesize = 48;
        orientation = "left";
        magnification = true;
        largesize = 64;

        persistent-apps = [
          { app = "/System/Applications/Utilities/Terminal.app"; }
          { app = "/Applications/Firefox.app"; }
          { app = "/Applications/Visual Studio Code.app"; }      
        ];
      };
      
      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
        AppleShowAllExtensions = true;
        NewWindowTarget = "Home";
      };
    };

    system.activationScripts.defaultBrowser.text = ''
      ${pkgs.duti}/bin/duti -s org.mozilla.firefox http
      ${pkgs.duti}/bin/duti -s org.mozilla.firefox https
      ${pkgs.duti}/bin/duti -s org.mozilla.firefox .html all
      ${pkgs.duti}/bin/duti -s org.mozilla.firefox .htm all
    '';

 	  system.primaryUser = "liam";

    nix.settings.experimental-features = [
 	    "nix-command"
 	    "flakes"
 	  ];

  	nixpkgs.config.allowUnfree = true;

 	  users.users.liam.home = "/Users/liam";

	  environment.systemPackages = with pkgs; [
      duti
 	    git
 	    neovim
      wget
      bottom
 	  ];

          programs.zsh.enable = true;

        })

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "liam";
            autoMigrate = true;
          };

          homebrew = {
            enable = true;

            onActivation = {
              autoUpdate = true;
              upgrade = true;
              cleanup = "zap";
            };

            casks = [
              "firefox"
              "visual-studio-code"
              "keepassxc"
            ];
          };
        }

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.liam = { pkgs, ... }: {
              home.username = "liam";
              home.homeDirectory = "/Users/liam";
              home.stateVersion = "25.05";

              home.packages = with pkgs; [ ];

              programs.home-manager.enable = true;

              programs.git = {
                enable = true;

                signing = {
                  key = "~/.ssh/id_ed25519.pub";
                  signByDefault = true;
                };

                settings = {
                  user = {
                    name = "Liam Bunch";
                    email = "liam@liambunch.com";
                  };
                  gpg.format = "ssh";
                  init.defaultBranch = "main";
                  pull.rebase = true;
                };
              };
            };
          };
        }
      ];
    };
  };
}