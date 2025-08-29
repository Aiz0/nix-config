{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.lanraragi = {
    enable = lib.mkEnableOption "LANraragi manga/doujinshi web application";
    supplementaryGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [""];
      description = "Extra groups under which lanraragi runs.";
    };
  };

  config = lib.mkIf config.myNixOS.services.lanraragi.enable {
    services.lanraragi = {
      enable = true;
      openFirewall = true; # port 3000
    };

    systemd.services.lanraragi.serviceConfig.supplementaryGroups = config.myNixOS.services.lanraragi.supplementaryGroups;
  };
}
