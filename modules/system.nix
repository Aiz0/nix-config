{
  pkgs,
  lib,
  ...
}: {
  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  programs.dconf.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # disable root login
      #PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    neofetch
    ghostty
    starship
    fuzzel
    nixd
    alejandra
    gtrash
  ];

  # required for hyprlock to perform authentication
  security.pam.services.hyprlock = {};

  services.tailscale.enable = true;
  services.tailscale.extraSetFlags = ["--operator=aiz"];

  # Set XDG directories
  # I like to have a clean home
  environment.sessionVariables = let
    local = "$HOME/local";
  in {
    XDG_CONFIG_HOME = local + "/config";
    XDG_CACHE_HOME = local + "/cache";
    XDG_STATE_HOME = local + "/state";
    XDG_DATA_HOME = local + "/share";
  };
}
