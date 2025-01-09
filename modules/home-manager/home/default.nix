{ ... }:

{
  imports = [
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
}
