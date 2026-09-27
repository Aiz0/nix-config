_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    ...
  }: let
    cfg = {
      port = 8789;
      dataDir = "/var/lib/chaptarr";
      downloadDir = "/mnt/data/downloads/chaptarr";
      audiobookDir = "/mnt/data/media/audiobooks/chaptarr";
      ebookDir = "/mnt/data/media/ebooks/chaptarr";
      user = "chaptarr";
      group = "chaptarr";
    };
    UID = 879;
    GID = 879;
  in {
    virtualisation.oci-containers.containers."chaptarr" = {
      image = "docker.io/chaptarr/chaptarr:latest";
      volumes = [
        "${cfg.dataDir}:/config:rw"
        "${cfg.audiobookDir}:/audiobooks:rw"
        "${cfg.ebookDir}:/ebooks:rw"
        "${cfg.downloadDir}:/downloads:rw"
      ];
      ports = [
        "${toString cfg.port}:8789"
      ];
      environment = {
        "PUID" = toString UID;
        "PGID" = toString GID;
        "TZ" = config.time.timeZone;
      };
    };

    systemd.services."podman-chaptarr" = {
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

    users.users = lib.mkIf (cfg.user == "chaptarr") {
      chaptarr = {
        inherit (cfg) group;
        uid = UID;
      };
    };

    users.groups = lib.mkIf (cfg.group == "chaptarr") {
      chaptarr = {gid = GID;};
    };

    systemd = {
      tmpfiles.rules = [
        "d ${cfg.dataDir} 0755 chaptarr chaptarr"
        "d ${cfg.downloadDir} 0755 chaptarr chaptarr"
        "d ${cfg.audiobookDir} 0755 chaptarr chaptarr"
        "d ${cfg.ebookDir} 0755 chaptarr chaptarr"
      ];
    };
  };
}
