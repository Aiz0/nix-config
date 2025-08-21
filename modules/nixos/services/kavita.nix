{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.kavita = {
    enable = lib.mkEnableOption "Kavita media server";

    tokenKeyFile = lib.mkOption {
      description = "Key file to use for TokenKey";
      default = config.age.secrets.kavitaTokenKey.path or null;
      type = lib.types.nullOr lib.types.path;
    };

    dataDir = lib.mkOption {
      description = "Data directory to use.";
      default = "/var/lib";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.myNixOS.services.kavita.enable {
    assertions = [
      {
        assertion = config.myNixOS.services.kavita.tokenKeyFile != null;
        message = "config.kavita.tokenKeyFile cannot be null.";
      }
    ];
    services.kavita = {
      enable = true;
      dataDir = "${config.myNixOS.services.kavita.dataDir}/kavita";
      tokenKeyFile = config.age.secrets.kavitaTokenKey.path;
    };
  };
}
