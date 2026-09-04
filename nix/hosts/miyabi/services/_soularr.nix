_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    ...
  }: let
    # I haven't gotten permissions to work correctly
    # and right now it always tries to grab stuff again
    # even if it exists in the download directory
    cfg = {
      dataDir = "/var/lib/soularr";
      user = "slskd";
      group = "media";
      downloadDir = "/mnt/data/downloads/soulseek/completed";
    };
  in {
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
