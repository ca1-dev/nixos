{ pkgs, inputs, ... }:

{
  imports = [
    ./ca1.nix
    ./hyprland.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    (inputs.ignis.packages.${pkgs.system}.default.override {
      enableAudioService = true;
      useDartSass = true;
    })

    fzf
    git
    htop
    neovim
    p7zip
    ripgrep
    tldr
    viu
    yadm
    zoxide
    zsh

    gtk-engine-murrine
    mpv
    networkmanagerapplet
    pcmanfm
    wezterm
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.neovim.defaultEditor = true;
  programs.dconf.enable = true;

  fonts.packages = with pkgs;
    [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      inter
    ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Inter" ];
      monospace = [ "Noto Monospace" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  networking = {
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/London";

  programs.nix-ld.enable = true;
}
