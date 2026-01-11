{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = builtins.concatStringsSep " " [
          "${pkgs.greetd.tuigreet}/bin/tuigreet"
          "--cmd 'sh -c \"source /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh && start-hyprland\"'"
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
