{ pkgs, ... }:

let
  colors = {
    rosewater = "#f5e0dc";
    flamingo = "#f2cdcd";
    pink = "#f5c2e7";
    mauve = "#cba6f7";
    red = "#f38ba8";
    maroon = "#eba0ac";
    peach = "#fab387";
    yellow = "#f9e2af";
    green = "#a6e3a1";
    teal = "#94e2d5";
    sky = "#89dceb";
    sapphire = "#74c7ec";
    blue = "#89b4fa";
    lavender = "#b4befe";
    text = "#cdd6f4";
    subtext_1 = "#bac2de";
    subtext_0 = "#a6adc8";
    overlay_2 = "#9399b2";
    overlay_1 = "#7f849c";
    overlay_0 = "#6c7086";
    surface_2 = "#585b70";
    surface_1 = "#45475a";
    surface_0 = "#313244";
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
  };
in
{
  imports = [
    ../theme.nix
  ];

  home.sessionVariables = {
    THEME = "catppuccin-mocha";
  };

  home.pointerCursor.name = "Adwaita";
  home.pointerCursor.package = pkgs.adwaita-icon-theme;

  programs.fzf.colors = with colors; {
    fg = text;
    bg = base;
    preview-fg = text;
    preview-bg = base;
    hl = mauve;
    "fg+" = text;
    "bg+" = base;
    gutter = base;
    "hl+" = mauve;
    info = overlay_2;
    border = mauve;
    prompt = blue;
    pointer = mauve;
    marker = blue;
    spinner = mauve;
    header = mauve;
  };

  gtk = {
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "mauve" ];
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };
  };

  theme = {
    firefoxTheme = pkgs.nur.repos.rycee.firefox-addons.tokyo-night-v2;
  };
}
