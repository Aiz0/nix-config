{
  config,
  lib,
  ...
}: {
  options.myHome.profiles.xdg.enable = lib.mkEnableOption "XDG dirs configuration and application variables";

  config = lib.mkIf config.myHome.profiles.xdg.enable {
    # right now these are also set in nixos profile base
    xdg = let
      local = "${config.home.homeDirectory}/local";
    in {
      enable = true;
      configHome = local + "/config";
      cacheHome = local + "/cache";
      stateHome = local + "/state";
      dataHome = local + "/share";
    };

    # Fix various applications to respect the XDG basedir spec
    # Applications that don't have custom configuration are set here
    programs.bash.historyFile = "${config.xdg.stateHome}/bash/history";
    gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    programs.gpg.homedir = "${config.xdg.dataHome}/gnupg";

    # These don't let you set it via nix config
    home.sessionVariables = {
      STARSHIP_CACHE = config.xdg.cacheHome + "/starship";
    };
  };
}
