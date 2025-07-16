{
  pkgs,
  lib,
  ...
}: {
  # ============================= User related =============================

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # given the users in this list the right to specify additional substituters via:
  #    1. `nixConfig.substituers` in `flake.nix`
  #    2. command line args `--options substituers http://xxx`
  nix.settings.trusted-users = ["aiz"];

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
    # don't pollute home with nix files
    use-xdg-base-directories = true;

    substituters = [
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    builders-use-substitutes = true;
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_CTYPE = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_TIME = "en_DK.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_MESSAGES = "en_DK.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  programs.niri.enable = true;
  programs.fish.enable = true;

  programs.dconf.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

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

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.power-profiles-daemon = {
    enable = true;
  };
  security.polkit.enable = true;

  services = {
    dbus.packages = [pkgs.gcr];

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    udisks2 = {
      enable = true;
    };
    gvfs = {
      enable = true;
    };

    #udev.packages = with pkgs; [gnome-settings-daemon];
  };

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
