_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    ...
  }: let
    cfg = {
      port = 8787;
      dataDir = "/var/lib/bindery";
      downloadDir = "/mnt/data/downloads/bindery";
      libraryDir = "/mnt/data/media/bindery";
      user = "bindery";
      group = "bindery";
    };
    UID = 872;
    GID = 872;
  in {
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
      environment = {
        "BINDERY_PUID" = toString UID;
        "BINDERY_PGID" = toString GID;
        "TZ" = config.time.timeZone;
      };
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
