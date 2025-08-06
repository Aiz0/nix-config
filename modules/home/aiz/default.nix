{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./desktop
    ./programs
    ./services
    ./assets
  ];
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

  # qt = {
  #   enable = true;
  #   platformTheme.name = "qt5ct";
  #   style.name = "breeze";
  # };

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
    STARSHIP_CACHE = config.xdg.cacheHome + "/starship";
  };
  programs.bash.historyFile = "${config.xdg.stateHome}/bash/history";
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  programs.gpg.homedir = "${config.xdg.dataHome}/gnupg";
}
