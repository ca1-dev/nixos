{ home-manager, ... }: {
  imports = [ ./options.nix ];
  home-manager.users.ca1 = {
    imports = [
      ./themes/tokyonight
      ./home
    ];
  };
}
