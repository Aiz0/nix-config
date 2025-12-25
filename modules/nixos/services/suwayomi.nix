{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.suwayomi = {
    enable = lib.mkEnableOption "Suwayomi manga server";

    dataDir = lib.mkOption {
      description = "Data directory to use.";
      default = "/var/lib";
      type = lib.types.str;
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "media";
      description = "Group under which suwayomi-server runs.";
    };

    downloadsDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.myNixOS.services.suwayomi.dataDir}/downloads";
      description = "Directory where downloaded manga will be stored.";
    };
  };

  config = lib.mkIf config.myNixOS.services.suwayomi.enable {
    services.suwayomi-server = {
      enable = true;
      openFirewall = true;
      dataDir = "${config.myNixOS.services.suwayomi.dataDir}/suwayomi";
      group = config.myNixOS.services.suwayomi.group;
      settings.server = {
        port = 8585; # default is 8080
        extensionRepos = [
          # Keiyoushi - https://keiyoushi.github.io/
          "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
        ];
        downloadsPath = config.myNixOS.services.suwayomi.downloadsDir;
      };
    };
  };
}
