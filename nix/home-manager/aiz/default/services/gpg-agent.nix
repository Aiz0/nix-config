_: {
  flake.homeModules.aiz = {config, ...}: {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableFishIntegration = true;
    };
  };
}
