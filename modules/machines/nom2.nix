{ config, lib, pkgs, modulesPath, inputs, ... }:

let
  amd64Pkgs = import <nixpkgs> { hostPlatform = "x86_64-linux"; config.allowUnfree = true; };
in
{
  environment.sessionVariables.MOZ_GMP_PATH = [ "${pkgs.widevine-cdm-lacros}/gmp-widevinecdm/system-installed" ];
  nixpkgs.overlays = [ inputs.nixos-aarch64-widevine.overlays.default ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
      settings.globalOptions = {
        "Hotkey/TriggerKeys"."0" = "Control+Shift+space";
      };
    };
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

    brightnessctl
  ];

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        #devices = [
        #"/dev/input/by-path/platform-2a9b30000.input-event-kbd"
        #];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defvar
            tap-time 0
            hold-time 150

            left-hand-keys (
              q w e r t
              a s d f g
              z x c v b
              )
            right-hand-keys (
              y u i o p
              h j k l ;
              n m , . /
              )
          )

          (deffakekeys
            to-base (layer-switch base)
          )

          (defalias
            sym (layer-toggle sym)
            base (layer-switch base)
            gaming (layer-switch gaming)

            tap (multi
              (layer-switch nomods)
              (on-idle-fakekey to-base tap 20)
            )

            a (tap-hold-release-keys $tap-time $hold-time (multi a @tap) lmet $left-hand-keys)
            s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lalt $left-hand-keys)
            d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lctl $left-hand-keys)
            f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lsft $left-hand-keys)
            j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rsft $right-hand-keys)
            k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rctl $right-hand-keys)
            l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) ralt $right-hand-keys)
            ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) rmet $right-hand-keys)
            space (tap-hold-release $tap-time  $hold-time (multi Space @tap) @sym)
            backspace (tap-hold-release $tap-time  $hold-time (multi Backspace @tap) @sym)
          )

          (defsrc
            1 2 3 4 5 6 7 8 9 0 Backspace

            q w e r t y u i o p
            a s d f g h j k l ;
            z x c v b n m , . /

            Space rmet lmet
          )

          (deflayer base
              _ _ _ _ _ _ _ _ _ _ Delete

              _  _  _  _  _ _ _  _  _  _
              @a @s @d @f _ _ @j @k @l @;
              _  _  _  _  _ _ _  _  _  _

              @space @backspace @gaming
          )

          (deflayer nomods
              _ _ _ _ _ _ _ _ _ _ Delete

              _ _ _ _ _ _ _ _ _ _
              _ _ _ _ _ _ _ _ _ _
              _ _ _ _ _ _ _ _ _ _

              _ _ _
          )

          (deflayer sym
              F1 F2 F3 f4 F5 F6 F7 F8 F9 F10 _

              1 2 3 4      5   6      7     8 9 0
              _ _ _ Escape tab Backspace Enter [ ] '
              _ _ _ _      `   -      =     _ _ \

              _ _ _
          )

          (deflayer gaming
            _ _ _ _ _ _ _ _ _ _ Delete

            _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ _ _ _

            _ _ @base
          )
        '';
      };
    };
  };

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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true;

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

  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl set 2%+"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl set 2%-"; }
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
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "usb_storage" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/95ce4a46-b753-441f-a190-e72f651324fb";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/5721-1F10";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
