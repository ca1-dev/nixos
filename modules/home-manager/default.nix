{ home-manager, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.ca1 = {
      imports = [
        ./themes/tokyonight
        ./firefox.nix
      ];

      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        size = 24;
      };

      programs.fzf = {
        enable = true;
      };

      gtk = {
        enable = true;
      };

      qt = {
        enable = true;
        platformTheme.name = "gtk";
      };

      home.stateVersion = "23.11";
    };
  };
}
