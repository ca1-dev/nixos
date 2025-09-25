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
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-aarch64-widevine = {
      url = "github:epetousis/nixos-aarch64-widevine";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-muvm-fex = {
      url = "github:nrabulinski/nixos-muvm-fex/native-build";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ignis, ... }@inputs: {
    nixosConfigurations = {
      homepc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/nixos
          ./modules/home-manager
          ./modules/machines/homepc.nix

          home-manager.nixosModules.home-manager
          inputs.nur.modules.nixos.default
        ];
      };

      nom = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        pkgs = import nixpkgs { system = "aarch64-linux"; config.allowUnfree = true; };
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/nixos
          ./modules/home-manager
          ./modules/machines/nom.nix

          home-manager.nixosModules.home-manager
          inputs.nur.modules.nixos.default
          inputs.apple-silicon.nixosModules.apple-silicon-support
        ];
      };

      nom2 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        pkgs = import nixpkgs { system = "aarch64-linux"; config.allowUnfree = true; };
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/nixos
          ./modules/home-manager
          ./modules/machines/nom2.nix

          home-manager.nixosModules.home-manager
          inputs.nur.modules.nixos.default
          inputs.apple-silicon.nixosModules.apple-silicon-support
        ];
      };
    };
  };
}
