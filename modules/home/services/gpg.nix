{
  config,
  lib,
  ...
}: {
  options.myHome.services.gpg.enable = lib.mkEnableOption "Enable GPG services and make gpg home directory xdg compliant";

  config = lib.mkIf config.myHome.services.gpg.enable {
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
