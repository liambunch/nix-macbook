{ self, pkgs, ... }:

{   
    environment.systemPackages = with pkgs; [
        neovim
    ];

    nix.settings.experimental-features = "nix-command flakes";

    security.pam.services.sudo_local.touchIdAuth = true;

    system.configurationRevision = self.rev or self.dirtyRev or null;

    system.stateVersion = 6;

    nixpkgs.hostPlatform = "aarch64-darwin";

    nixpkgs.config.allowUnfree = true;

    users.users.liam.home = "/Users/Liam";

    system.primaryUser = "Liam";

    system.defaults = {
        finder = {
            ShowPathbar = true;
            ShowStatusBar = true;
            AppleShowAllExtensions = true;
            NewWindowTarget = "Home";
            FXPreferredViewStyle = "Nlsv";
        };

        dock = {
            autohide = true;
            orientation = "left";
            tilesize = 48;
            show-recents = false;

            persistent-apps = [
                "/System/Applications/Apps.app"
                "/System/Applications/Utilities/Terminal.app"
                "/Users/liam/Applications/Home Manager Apps/Firefox.app"
                "/Users/liam/Applications/Home Manager Apps/Thunderbird.app"
                "/Users/liam/Applications/Home Manager Apps/VSCodium.app"
                "/Users/liam/Applications/Home Manager Apps/Vesktop.app"
                "/Applications/UniFi Endpoint.app"
            ];
        };
    };

    homebrew = {
        enable = true;

        casks = [
            "unifi-identity-endpoint"
        ];

        onActivation = {
            autoUpdate = true;
            upgrade = true;
            cleanup = "zap";
        };
    };
}
