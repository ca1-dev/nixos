{ config, lib, pkgs, nixpkgs, modulesPath, ... }:

let
  amd64Pkgs = import <nixpkgs> { system = "x86_64-linux"; config.allowUnfree = true; };
in
{
  networking.hostName = "nom";

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    nodejs
    rustup
    unzip
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
    withRust = true;
    setupAsahiSound = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    extractPeripheralFirmware = true;
    peripheralFirmwareDirectory = /home/ca1/asahi;
  };

  nix.settings = {
    auto-optimise-store = true;
    extra-substituters = [
      "https://nixos-asahi.cachix.org"
    ];
    extra-trusted-public-keys = [
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

  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  system.stateVersion = "24.05";


  # from hardware config
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/fafb25a5-dc61-4535-a9b2-56f784611639";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/1891-1610";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enu1u4c2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
