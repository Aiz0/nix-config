{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS.services.soularr;
in {
  options.myNixOS.services.soularr = {
    enable = lib.mkEnableOption "Soularr, connect lidarr with soulseek";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/soularr";
      description = "The directory where soularr stores its data files.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "slskd";
      description = "User account under which soularr runs, default slskd just to make things easier";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "media";
      description = "Group under which soularr runs";
    };

    downloadDir = lib.mkOption {
      type = lib.types.path;
      default = "/mnt/data/downloads/soulseek/completed";
      description = "The directory where slskd downloads files.";
    };
  };

  config = lib.mkIf cfg.enable {
    myNixOS.programs.podman.enable = true;
    virtualisation.oci-containers.containers."soularr" = {
      image = " mrusse08/soularr";
      volumes = [
        "${cfg.dataDir}:/data:rw"
        "${cfg.downloadDir}:/downloads:rw"
      ];
      user = "981:900";
      environment = {
        "TZ" = config.time.timeZone;
        "SCRIPT_INTERVAL" = "300";
      };
    };
    systemd.services."podman-soularr" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "on-failure";
      };
      partOf = [
        "podman-compose-root.target"
      ];
      wantedBy = [
        "podman-compose-root.target"
      ];
    };
  };
}
