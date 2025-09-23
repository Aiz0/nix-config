{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHome.aiz.programs.ssh.enable = lib.mkEnableOption "openSSH client";

  config = lib.mkIf config.myHome.aiz.programs.ssh.enable {
    programs.ssh = {
      enable = true;
      package = pkgs.openssh;
      enableDefaultConfig = false;
    };
  };
}
