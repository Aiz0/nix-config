_: {
  flake.homeModules.aiz = {
    programs.fish = {
      enable = true;
      shellInit = ''
        function fish_greeting; end
        function fish_title; end
      '';
    };
  };
}
