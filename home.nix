{ pkgs, ... }:

{
    home = {
        username = "liam";
        homeDirectory = "/Users/liam";
        stateVersion = "26.05";
    };

    home.packages = with pkgs; [
        fastfetch
        mpv
        yt-dlp
        librewolf
        thunderbird
        vscodium
        vesktop
        freelens-bin
    ];

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
}
