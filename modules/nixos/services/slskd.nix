{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS.services.slskd;
in {
  options.myNixOS.services.slskd = {
    enable = lib.mkEnableOption "Slskd, A modern client-server application for the Soulseek file-sharing network";

    downloadDir = lib.mkOption {
      type = lib.types.path;
      default = "/mnt/data/downloads/soulseek";
      description = "The directory where slskd downloads files";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "slskd";
      description = "User account under which slskd runs.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "slskd";
      description = "Group under which slskd runs.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 5030;
      description = "slskd web UI port.";
    };

    environmentFile = lib.mkOption {
      description = "Path to the environment file for secrets";
      default = config.age.secrets.slskdEnv.path or null;
      type = lib.types.nullOr lib.types.path;
    };
  };

  config = lib.mkIf cfg.enable {
    services.slskd = {
      enable = true;
      inherit (cfg) user;
      inherit (cfg) group;
      settings = {
        web.port = cfg.port;
        directories = {
          downloads = "${cfg.downloadDir}/completed";
          incomplete = "${cfg.downloadDir}/incomplete";
        };
        shares.directories = [
          "[Music]/mnt/data/media/music"
        ];
      };
      openFirewall = true;
      inherit (cfg) environmentFile;
    };

    systemd = {
      tmpfiles.rules = [
        "d ${cfg.downloadDir} 0755 ${cfg.user} ${cfg.group}"
        "d ${cfg.downloadDir}/completed 0755 ${cfg.user} ${cfg.group}"
        "d ${cfg.downloadDir}/incomplete 0755 ${cfg.user} ${cfg.group}"
      ];
    };
  };
}
