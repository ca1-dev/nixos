{ config, lib, pkgs, modulesPath, inputs, ... }:

let
  amd64Pkgs = import <nixpkgs> { system = "x86_64-linux"; config.allowUnfree = true; };
in
{
  environment.sessionVariables.MOZ_GMP_PATH = [ "${pkgs.widevine-cdm-lacros}/gmp-widevinecdm/system-installed" ];
  nixpkgs.overlays = [ inputs.nixos-aarch64-widevine.overlays.default ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  networking.hostName = "nom2";

  environment.systemPackages = with pkgs; [
    (pkgs.extend inputs.nixos-muvm-fex.overlays.default).muvm
    squashfsTools

    gcc
    gnumake
    nodejs
    rustup
    unzip

    ghostty
    tmux
  ];

  services.upower.enable = true;

  zramSwap.enable = true;

  boot = {
    m1n1CustomLogo = ../../assets/bootlogo-m1n1.png;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    binfmt.emulatedSystems = [ "x86_64-linux" ];
  };

  hardware.asahi = {
    setupAsahiSound = true;
    extractPeripheralFirmware = true;
    peripheralFirmwareDirectory = /home/ca1/asahi;
  };

  nix.settings = {
    auto-optimise-store = true;
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixos-asahi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixos-asahi.cachix.org-1:CPH9jazpT/isOQvFhtAZ0Z18XNhAp29+LLVHr0b2qVk="
    ];
  };

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  networking.dhcpcd.enable = true;
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  system.stateVersion = "25.11";

  # from hardware config
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "usb_storage" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/95ce4a46-b753-441f-a190-e72f651324fb";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5721-1F10";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
