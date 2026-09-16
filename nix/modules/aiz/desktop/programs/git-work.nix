_: {
  flake.nixosModules.desktop = {
    config,
    self,
    ...
  }: {
    sops.secrets.git-work-config = {
      sopsFile = self + "/secrets/git-work.ini";
      format = "ini";
      mode = "0400";
      owner = config.users.users.aiz.name;
      group = config.users.users.aiz.group;
    };
  };
  flake.homeModules.aizDesktop = {osConfig, ...}: {
    programs.git = {
      includes = [
        {
          condition = "gitdir:~/work/";
          inherit (osConfig.sops.secrets.git-work-config) path;
        }
      ];
    };
  };
}
