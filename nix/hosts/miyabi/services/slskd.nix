_: {
  flake.nixosModules.miyabi = {config, ...}: let
    cfg = {
      downloadDir = "/mnt/data/downloads/soulseek";
      user = "slskd";
      group = "media";
      port = 5030;
      environmentFile = config.age.secrets.slskdEnv.path or null;
    };
  in {
    services.slskd = {
      enable = true;
      inherit (cfg) user;
      inherit (cfg) group;
      settings = {
        web.port = cfg.port;
        directories = {
          downloads = "${cfg.downloadDir}/completed";
          incomplete = "${cfg.downloadDir}/incomplete";
        };
        shares.directories = [
          "[Music]/mnt/data/media/music"
        ];
      };
      openFirewall = true;
      inherit (cfg) environmentFile;
    };

    systemd = {
      tmpfiles.rules = [
        "d ${cfg.downloadDir} 0755 ${cfg.user} ${cfg.group}"
        "d ${cfg.downloadDir}/completed 0755 ${cfg.user} ${cfg.group}"
        "d ${cfg.downloadDir}/incomplete 0755 ${cfg.user} ${cfg.group}"
      ];
    };
  };
}
