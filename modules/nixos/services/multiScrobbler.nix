{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS.services.multiScrobbler;
  UID = 870;
  GID = 870;
in {
  options.myNixOS.services.multiScrobbler = {
    enable = lib.mkEnableOption "multiScrobbler";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/multi-scrobbler";
      description = "The directory where multiScrobbler stores its data files.";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 9078;
      description = "Port to listen on";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "multi-scrobbler";
      description = "User account under which multi-scrobbler runs.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "multi-scrobbler";
      description = "Group under which multi-scrobbler runs.";
    };

    environmentFile = lib.mkOption {
      description = "Path to the environment file";
      default = config.age.secrets.multiScrobblerEnv.path or null;
      type = lib.types.nullOr lib.types.path;
    };
  };

  config = lib.mkIf cfg.enable {
    myNixOS.programs.podman.enable = true;
    virtualisation.oci-containers.containers."multi-scrobbler" = {
      image = "ghcr.io/foxxmd/multi-scrobbler";
      volumes = [
        "${cfg.dataDir}:/config:rw"
      ];
      ports = [
        "${toString cfg.port}:9078"
      ];
      environment = {
        "PGID" = "1001";
        "PUID" = "1001";
        "TZ" = config.time.timeZone;
      };
      environmentFiles = [
        cfg.environmentFile
      ];
    };
    systemd.services."podman-multi-scrobbler" = {
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
    users.users = lib.mkIf (cfg.user == "multi-scrobbler") {
      multi-scrobbler = {
        inherit (cfg) group;
        uid = UID;
      };
    };

    users.groups = lib.mkIf (cfg.group == "multi-scrobbler") {
      multi-scrobbler = {gid = GID;};
    };
    systemd = {
      tmpfiles.rules = [
        "d ${cfg.dataDir} 0755 multi-scrobbler multi-scrobbler"
      ];
    };
  };
}
