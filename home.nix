{ pkgs, ... }:

{
    home = {
        username = "liam";
        homeDirectory = "/Users/Liam";
        stateVersion = "26.05";
    };

    home.packages = with pkgs; [
        fastfetch
        firefox
        vscodium
        vesktop
        thunderbird
        mpv
        yt-dlp
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
