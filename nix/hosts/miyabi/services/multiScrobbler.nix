_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    ...
  }: let
    cfg = {
      environmentFile = config.age.secrets.multiScrobblerEnv.path or null;
      dataDir = "/var/lib/multi-scrobbler";
      user = "multi-scrobbler";
      group = "multi-scrobbler";
      port = 9078;
    };
    UID = 870;
    GID = 870;
  in {
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
