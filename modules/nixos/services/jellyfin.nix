{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.jellyfin = {
    enable = lib.mkEnableOption "Jellyfin media server";

    dataDir = lib.mkOption {
      description = "Data directory to use.";
      default = "/var/lib";
      type = lib.types.str;
    };

    jellyseer.enable = lib.mkEnableOption "Jellyfin request manager";
  };

  config = lib.mkIf config.myNixOS.services.jellyfin.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true; # port 8096
      dataDir = "${config.myNixOS.services.jellyfin.dataDir}/jellyfin";
    };
  };
}
