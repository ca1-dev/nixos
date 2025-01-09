{ config, lib, pkgs, modulesPath, ... }:

{
  networking.hostName = "homepc";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ca1" ];

  environment.systemPackages = with pkgs; [
    # dev
    clang
    clang-tools
    cmake
    gcc
    gnumake
    nodejs_22
    python3
    rustup
    unzip

    # other
    brave
    gimp
    prismlauncher
    qjackctl
    reaper
    vesktop
    xorg.xhost
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  hardware.steam-hardware.enable = true;

  hardware.graphics = {
    extraPackages = [
      pkgs.intel-ocl
    ];

    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  system.stateVersion = "23.11";

  # from hardware-configuration.nix
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/214a2764-69ba-4afd-b7b5-fafc95aa1e64";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
