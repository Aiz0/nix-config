{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS.services.bindery;
  UID = 872;
  GID = 872;
in {
  options.myNixOS.services.bindery = {
    enable = lib.mkEnableOption "bindery";

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/bindery";
      description = "The directory where bindery stores its config and database.";
    };

    downloadDir = lib.mkOption {
      type = lib.types.path;
      default = "/mnt/data/downloads/bindery";
      description = "Directory for completed downloads.";
    };

    libraryDir = lib.mkOption {
      type = lib.types.path;
      default = "/mnt/data/media/bindery";
      description = "Destination for imported books.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8787;
      description = "Port to listen on";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "bindery";
      description = "User account under which bindery runs.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "bindery";
      description = "Group under which bindery runs.";
    };

    logLevel = lib.mkOption {
      type = lib.types.enum ["debug" "info" "warn" "error"];
      default = "info";
      description = "Log level for bindery.";
    };

    environmentFile = lib.mkOption {
      description = "Path to the environment file";
      default = config.age.secrets.binderyEnv.path or null;
      type = lib.types.nullOr lib.types.path;
    };

    environment = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra environment variables to pass to bindery.";
    };
  };

  config = lib.mkIf cfg.enable {
    myNixOS.programs.podman.enable = true;

    virtualisation.oci-containers.containers."bindery" = {
      image = "ghcr.io/vavallee/bindery:latest";
      user = "${toString UID}:${toString GID}";
      volumes = [
        "${cfg.dataDir}:/config:rw"
        "${cfg.libraryDir}:/books:rw"
        "${cfg.downloadDir}:/downloads:rw"
      ];
      ports = [
        "${toString cfg.port}:8787"
      ];
      environment =
        {
          "BINDERY_LOG_LEVEL" = cfg.logLevel;
          "BINDERY_PUID" = toString UID;
          "BINDERY_PGID" = toString GID;
          "TZ" = config.time.timeZone;
        }
        // cfg.environment;
      environmentFiles = lib.optional (cfg.environmentFile != null) cfg.environmentFile;
    };

    systemd.services."podman-bindery" = {
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

    users.users = lib.mkIf (cfg.user == "bindery") {
      bindery = {
        inherit (cfg) group;
        uid = UID;
      };
    };

    users.groups = lib.mkIf (cfg.group == "bindery") {
      bindery = {gid = GID;};
    };

    systemd = {
      tmpfiles.rules = [
        "d ${cfg.dataDir} 0755 bindery bindery"
        "d ${cfg.downloadDir} 0755 bindery bindery"
        "d ${cfg.libraryDir} 0755 bindery bindery"
      ];
    };
  };
}
