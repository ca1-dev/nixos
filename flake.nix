{
  description = "my nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis.url = "github:linkfrg/ignis";
  };

  outputs = { nixpkgs, home-manager, nur, ignis, apple-silicon, ... }: {
    nixosConfigurations = {
      homepc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          nur.modules.nixos.default

          { environment.systemPackages = [ ignis.packages.x86_64-linux.ignis ]; }

          ./modules/nixos
          ./modules/machines/homepc.nix

          {
            imports = [ ./modules/home-manager/options.nix ];

            home-manager.users.ca1 = {
              imports = [
                ./modules/home-manager/themes/tokyonight
                ./modules/home-manager/home
              ];
            };
          }
        ];
      };

      nom = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          apple-silicon.nixosModules.apple-silicon-support

          home-manager.nixosModules.home-manager
          nur.modules.nixos.default

          { environment.systemPackages = [ ignis.packages.aarch64-linux.ignis ]; }


          ./modules/nixos
          ./modules/machines/nom.nix

          {
            imports = [ ./modules/home-manager/options.nix ];

            home-manager.users.ca1 = {
              imports = [
                ./modules/home-manager/themes/tokyonight
                ./modules/home-manager/home
              ];
            };
          }
        ];
      };
    };
  };
}
