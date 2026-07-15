{ pkgs, ... }:
{   
    environment.systemPackages = with pkgs; [
        neovim
    ];
    nix.settings.experimental-features = "nix-command flakes";
    security.pam.services.sudo_local.touchIdAuth = true;
    system.stateVersion = 6;
    nixpkgs.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowUnfree = true;
    users.users.liam.home = "/Users/liam";
    system.primaryUser = "liam";
    system.defaults = {
        dock = {
            autohide = true;
            tilesize = 48;
        };
        finder = {
            ShowPathbar = true;
            QuitMenuItem = true;
            ShowStatusBar = true;
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            NewWindowTarget = "Home";
            FXPreferredViewStyle = "Nlsv";
        };
    };
    homebrew = {
        enable = true;
        casks = [
        ];
        onActivation = {
            autoUpdate = true;
            upgrade = true;
            cleanup = "zap";
        };
    };
}