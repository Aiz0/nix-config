{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS.services.navidrome;
in {
  options.myNixOS.services.navidrome = {
    enable = lib.mkEnableOption "Navidrome media server";

    dataDir = lib.mkOption {
      description = "Data directory to use.";
      default = "/var/lib/navidrome";
      type = lib.types.str;
    };

    musicFolder = lib.mkOption {
      description = "Music folder to use.";
      default = "/mnt/data/media/music";
      type = lib.types.str;
    };

    jellyseer.enable = lib.mkEnableOption "Jellyfin request manager";
  };

  config = lib.mkIf cfg.enable {
    services.navidrome = {
      enable = true;
      openFirewall = true; # port 4533
      settings = {
        MusicFolder = cfg.musicFolder;
        DataFolder = cfg.dataDir;
        # Make it accessible via the tailnet
        Address = "0.0.0.0";
        baseURL = "https://${config.mySnippets.tailnet.networkMap.navidrome.vHost}";
      };
    };
  };
}
