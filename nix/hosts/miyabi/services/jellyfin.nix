_: {
  flake.nixosModules.miyabi = {config, ...}: {
    services.jellyfin = {
      enable = true;
      openFirewall = true; # port 8096
      dataDir = "/var/lib/jellyfin";
    };

    # Set up automated backups
    myBackup.paths = [
      "${config.services.jellyfin.dataDir}/data/backups"
    ];
  };
}
