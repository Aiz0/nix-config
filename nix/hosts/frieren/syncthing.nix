_: {
  flake.nixosModules.frieren = {
    config,
    self,
    ...
  }: let
    syncthingCert = config.sops.secrets.syncthing-cert.path;
    syncthingKey = config.sops.secrets.syncthing-key.path;
  in {
    sops.secrets = {
      syncthing-cert = {
        sopsFile = self + "/secrets/syncthing-frieren.yaml";
        key = "cert";
        owner = "aiz";
      };

      syncthing-key = {
        sopsFile = self + "/secrets/syncthing-frieren.yaml";
        key = "key";
        owner = "aiz";
      };
    };

    home-manager.users.aiz = {
      imports = [self.homeModules.syncthing];

      myOptions.syncthing = {
        enable = true;
        cert = syncthingCert;
        key = syncthingKey;

        folders = {
          sync.enable = true;
          obsidian.enable = true;
          backups.enable = true;
        };
      };
    };
  };
}
