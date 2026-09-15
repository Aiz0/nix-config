_: {
  flake.nixosModules.miyabi = {
    config,
    self,
    ...
  }: {
    sops.secrets.kavita-token-key.sopsFile = self + "/secrets/kavita.yaml";
    services.kavita = {
      enable = true;
      dataDir = "/var/lib/kavita";
      tokenKeyFile = config.sops.secrets.kavita-token-key.path;
    };
  };
}
