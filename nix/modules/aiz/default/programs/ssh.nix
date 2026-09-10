_: {
  flake.homeModules.aiz = {pkgs, ...}: {
    programs.ssh = {
      enable = true;
      package = pkgs.openssh;
      enableDefaultConfig = false;
    };
  };
}
