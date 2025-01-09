{ pkgs, ... }:

let
  colors = {
    bg_dark = "#16161e";
    bg = "#1a1b26";
    bg_highlight = "#292e42";
    terminal_black = "#414868";
    fg = "#c0caf5";
    fg_dark = "#a9b1d6";
    fg_gutter = "#3b4261";
    dark3 = "#545c7e";
    comment = "#565f89";
    dark5 = "#737aa2";
    blue0 = "#3d59a1";
    blue = "#7aa2f7";
    cyan = "#7dcfff";
    blue1 = "#2ac3de";
    blue2 = "#0db9d7";
    blue5 = "#89ddff";
    blue6 = "#b4f9f8";
    blue7 = "#394b70";
    magenta = "#bb9af7";
    magenta2 = "#ff007c";
    purple = "#9d7cd8";
    orange = "#ff9e64";
    yellow = "#e0af68";
    green = "#9ece6a";
    green1 = "#73daca";
    green2 = "#41a6b5";
    teal = "#1abc9c";
    red = "#f7768e";
    red1 = "#db4b4b";
  };
in
{
  imports = [
    ../theme.nix
  ];

  home.sessionVariables = {
    THEME = "tokyonight";
  };

  home.pointerCursor.name = "Adwaita";
  home.pointerCursor.package = pkgs.adwaita-icon-theme;

  programs.fzf.colors = with colors; {
    fg = fg;
    bg = bg;
    preview-fg = fg;
    preview-bg = bg;
    hl = blue;
    "fg+" = fg;
    "bg+" = bg_highlight;
    gutter = bg;
    "hl+" = blue;
    info = comment;
    border = blue;
    prompt = magenta;
    pointer = blue;
    marker = magenta;
    spinner = blue;
    header = blue;
  };

  gtk = {
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        themeVariants = [ "default" ];
        iconVariants = [ "Light" ];
      };
    };

    iconTheme = {
      name = "Tokyonight-Light";
    };
  };

  theme = {
    firefoxTheme = pkgs.nur.repos.rycee.firefox-addons.tokyo-night-v2;
  };
}
