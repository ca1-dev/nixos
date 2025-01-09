{ lib, ... }:

{
  options.theme = lib.mkOption {
    type = with lib.types;
      submodule {
        options = {
          colors = lib.mkOption { type = attrsOf str; };

          firefoxTheme = lib.mkOption { type = package; };
        };
      };
  };
}
