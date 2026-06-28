{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = builtins.concatStringsSep " " [
          "${pkgs.tuigreet}/bin/tuigreet"
          "--cmd 'sh /home/$USER/.config/hypr/hyprland/start.sh'"
          "--time"
          "--time-format '%a %d/%m %H:%M'"
          "--remember"
          "--asterisks"
          "--window-padding 1"
        ];
      };
    };
  };

  services.libinput = {
    enable = true;

    mouse = {
      accelProfile = "flat";
    };
  };
}
