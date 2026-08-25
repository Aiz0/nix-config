_: {
  flake.nixosModules.miyabi = {config, ...}: let
    tokenKeyFile = config.age.secrets.kavitaTokenKey.path or null;
  in {
    assertions = [
      {
        assertion = tokenKeyFile != null;
        message = "Kavita tokenKeyFile cannot be null.";
      }
    ];
    services.kavita = {
      enable = true;
      dataDir = "/var/lib/kavita";
      tokenKeyFile = tokenKeyFile;
    };
  };
}
