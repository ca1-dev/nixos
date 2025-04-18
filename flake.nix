{
  description = "my nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    nixos-aarch64-widevine = {
      url = "github:epetousis/nixos-aarch64-widevine";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis = {
      url = "github:linkfrg/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nur, ignis, apple-silicon, nixos-aarch64-widevine, ... }: {
    nixosConfigurations = {
      homepc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
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
        pkgs = import nixpkgs { system = "aarch64-linux"; config.allowUnfree = true; };
        modules = [
          apple-silicon.nixosModules.apple-silicon-support
          ({ pkgs, ... }:
            {
              nixpkgs.overlays = [ nixos-aarch64-widevine.overlays.default ];
              environment.sessionVariables.MOZ_GMP_PATH = [ "${pkgs.widevine-cdm-lacros}/gmp-widevinecdm/system-installed" ];
            })

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
