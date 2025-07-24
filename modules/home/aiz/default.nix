{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./desktop
    ./programs
    ./services
  ];
  home = {
    username = "aiz";
    homeDirectory = "/home/aiz";

    packages = with pkgs; [
      neofetch

      # archives
      zip
      unzip

      # gui
      nautilus # gnome file manager
      file-roller
      oculante # image viewer
      protonvpn-gui
    ];

    pointerCursor = {
      enable = true;
      package = pkgs.posy-cursors;
      name = "Posy_Cursor_Black";
    };

    stateVersion = "25.05";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
  programs.fish.enable = true;

  # Fixes home manager not respecting me
  # setting XDG environment variables
  xdg = let
    local = "/home/aiz/local";
  in {
    enable = true;
    configHome = local + "/config";
    cacheHome = local + "/cache";
    stateHome = local + "/state";
    dataHome = local + "/share";
  };

  # Fix various applications to respect the XDG basedir spec
  home.sessionVariables = {
    HISTFILE = config.xdg.stateHome + "/bash/history";
    GNUPGHOME = config.xdg.dataHome + "/gnupg";
    STARSHIP_CACHE = config.xdg.cacheHome + "/starship";
  };
}
