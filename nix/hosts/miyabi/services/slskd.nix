_: {
  flake.nixosModules.miyabi = {
    config,
    self,
    ...
  }: let
    cfg = {
      downloadDir = "/mnt/data/downloads/soulseek";
      user = "slskd";
      group = "media";
      port = 5030;
    };
  in {
    sops.secrets.slskd-env = {
      sopsFile = self + "/secrets/slskd.env";
      format = "dotenv";
    };
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
      environmentFile = config.sops.secrets.slskd-env.path;
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
