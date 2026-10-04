_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
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
    imports = [self.nixosModules.podman];

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

    users.users = lib.mkIf (cfg.user == "slskd") {
      slskd = {
        inherit (cfg) group;
        uid = 981;
      };
    };
    systemd = {
      services.slskd.serviceConfig.UMask = "002";
      tmpfiles.rules = [
        "d ${cfg.downloadDir} 2775 ${cfg.user} ${cfg.group}"
        "d ${cfg.downloadDir}/completed 2775 ${cfg.user} ${cfg.group}"
        "d ${cfg.downloadDir}/incomplete 2775 ${cfg.user} ${cfg.group}"
      ];
    };
  };
}
