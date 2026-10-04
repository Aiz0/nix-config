_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    self,
    ...
  }: let
    cfg = {
      dataDir = "/var/lib/soularr";
      user = config.users.users."slskd".uid;
      group = config.users.groups."media".gid;
    };
  in {
    # This needs stuff adjusted in config to work, it's not included in this module...
    # import path for lidarr

    imports = [self.nixosModules.podman];
    virtualisation.oci-containers.containers."soularr" = {
      image = "mrusse08/soularr";
      volumes = [
        "${cfg.dataDir}:/data:rw"
        "${config.services.slskd.settings.directories.downloads}:/downloads:rw"
      ];
      user = "${toString cfg.user}:${toString cfg.group}";
      ports = [
        "8265:8265"
      ];
      environment = {
        "TZ" = config.time.timeZone;
        "SCRIPT_INTERVAL" = "3600";
        "WEBUI_ENABLED" = "true";
      };
      # Needed so lidarr can actually import shit without issue
      # only if rename downloaded folders is on
      extraOptions = ["--umask=002"];
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
