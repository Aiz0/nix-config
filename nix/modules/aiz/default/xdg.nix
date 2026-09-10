_: {
  flake.homeModules.aiz = {config, ...}: {
    # right now these are also set in nixos default module
    xdg = let
      home = config.home.homeDirectory;
      user = "${home}/user";
      local = "${home}/local";
    in {
      enable = true;
      configHome = local + "/config";
      cacheHome = local + "/cache";
      stateHome = local + "/state";
      dataHome = local + "/share";

      userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = false;

        # in home dir
        download = "${home}/downloads";

        # in home/user dir
        documents = "${user}/documents";
        music = "${user}/music";
        pictures = "${user}/pictures";
        projects = "${user}/projects";
        # might change name of this later
        # idk if i wanna set up syncthing here yet
        publicShare = "${user}/shared";
        videos = "${user}/videos";

        # disabled
        templates = home;
        desktop = home;
      };
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
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      # Claude still not work, or whatever zed it is doing.
      CLAUDE_CONFIG_DIR = "${config.xdg.configHome}/claude";
    };
  };
}
