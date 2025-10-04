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
    # if they have a nix module that allows configuring this
    # then that should be set where they are enabled

    home.sessionVariables = {
      HISTFILE = "${config.xdg.stateHome}/bash/history";
      NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
      NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
      NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
      STARSHIP_CACHE = config.xdg.cacheHome + "/starship";
    };
  };
}
