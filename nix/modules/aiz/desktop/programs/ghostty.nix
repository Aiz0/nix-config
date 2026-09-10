_: {
  flake.homeModules.aizDesktop = {
    programs.ghostty = {
      enable = true;
      settings = {
        gtk-single-instance = true;
        quit-after-last-window-closed = false;
        window-inherit-working-directory = false;
      };
    };
  };
}
