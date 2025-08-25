{ pkgs, inputs, ... }:

{
  imports = [
    ./gui.nix
  ];

  nixpkgs.overlays = [ inputs.hyprland.overlays.hyprland-packages ];

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
