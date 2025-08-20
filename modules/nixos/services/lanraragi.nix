{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.lanraragi = {
    enable = lib.mkEnableOption "LANraragi manga/doujinshi web application";
  };

  config = lib.mkIf config.myNixOS.services.lanraragi.enable {
    services.lanraragi = {
      enable = true;
      openFirewall = true; # port 3000
    };
  };
}
