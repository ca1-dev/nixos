{ pkgs, ... }:

{
  imports = [
    ./gui.nix
  ];

  environment.systemPackages = with pkgs;
    [
      grimblast
      hyprlock
      hyprpaper
      hyprpicker
      tofi
      wl-clipboard
    ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
