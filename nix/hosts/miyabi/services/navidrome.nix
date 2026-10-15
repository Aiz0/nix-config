_: {
  flake.nixosModules.miyabi = {config, ...}: let
    cfg = {
      dataDir = "/var/lib/navidrome";
      musicFolder = "/mnt/data/media/music";
    };
  in {
    services.navidrome = {
      enable = true;
      openFirewall = true; # port 4533
      settings = {
        MusicFolder = cfg.musicFolder;
        DataFolder = cfg.dataDir;

        Backup = {
          Path = "${cfg.dataDir}/backups";
          Count = 7;
          # Cron like syntax, this should be everyt 24 hours at midnight, i should research this a bit more.
          Schedule = "0 0 * * *";
        };
        # Make it accessible via the tailnet
        Address = "0.0.0.0";
        baseURL = "https://${config.mySnippets.tailnet.networkMap.navidrome.vHost}";
      };
    };

    systemd = {
      tmpfiles.rules = [
        "d ${config.services.navidrome.settings.Backup.Path} 0700 navidrome navidrome"
      ];
    };

    myBackup.paths = [
      config.services.navidrome.settings.Backup.Path
    ];
  };
}
