{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myNixOS.services.komf;
  UID = 871;
  GID = 871;
in {
  options.myNixOS.services.komf = {
    enable = lib.mkEnableOption "Komf, Kavita and Komga Metadata Fetcher";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/komf";
      description = "The directory where komf stores its data files.";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 8085;
      description = "Port to listen on";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "komf";
      description = "User account under which komf runs.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "komf";
      description = "Group under which komf runs.";
    };

    environmentFile = lib.mkOption {
      description = "Path to the environment file for secrets";
      default = config.age.secrets.komfEnv.path or null;
      type = lib.types.nullOr lib.types.path;
    };
  };

  config = lib.mkIf cfg.enable {
    myNixOS.programs.podman.enable = true;
    virtualisation.oci-containers.containers."komf" = let
      # Komf Configuration
      komfConfig = pkgs.writeText "application.yml" ''
        kavita:
          baseUri: "https://kavita.miku-climb.ts.net"
          apiKey: "env:KOMF_KAVITA_API_KEY"
          eventListener:
            enabled: true
            metadataSeriesExcludeFilter: []
          metadataUpdate:
            default:
              aggregate: true
              updateModes: [API]
              postProcessing:
                seriesTitle: true
                alternativeSeriesTitleLanguages:
                  - "ja-ro"
                languageValue: "en"
          library:
            2:
              libraryType: "NOVEL"
            4:
              libraryType: "Manga"

        database:
          file: "/config/database.sqlite"
        metadataProviders:
          libraryProviders:
            2:
              mangaBaka:
                priority: 1
                enabled: true
                mediaType: "NOVEL"
                mode: "API"
            4:
              mangaBaka:
                priority: 1
                enabled: true
                mediaType: "MANGA"
                mode: "API"
      '';
    in {
      image = "sndxr/komf";
      volumes = [
        "${cfg.dataDir}:/config:rw"
        "${komfConfig}:/config/application.yml:ro"
      ];
      ports = [
        "${toString cfg.port}:8085"
      ];
      user = "${toString UID}:${toString GID}";
      environment = {
        "TZ" = config.time.timeZone;
      };
      environmentFiles = [
        cfg.environmentFile
      ];
    };
    systemd.services."podman-komf" = {
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
    users.users = lib.mkIf (cfg.user == "komf") {
      komf = {
        inherit (cfg) group;
        uid = UID;
      };
    };

    users.groups = lib.mkIf (cfg.group == "komf") {
      komf = {gid = GID;};
    };
    systemd = {
      tmpfiles.rules = [
        "d ${cfg.dataDir} 0755 komf komf"
      ];
    };
  };
}
