_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    ...
  }: let
    dataDir = "/var/lib/";
  in {
    services = {
      bazarr = {
        enable = true;
        dataDir = "${dataDir}/bazarr";
        openFirewall = true; # Port: 6767
      };

      lidarr = {
        enable = true;
        dataDir = "${dataDir}/lidarr/.config/Lidarr";
        openFirewall = true; # Port: 8686
      };

      prowlarr = {
        enable = true;
        dataDir = "${dataDir}/prowlarr";
        openFirewall = true; # Port: 9696
      };

      radarr = {
        enable = true;
        dataDir = "${dataDir}/radarr/.config/Radarr/";
        openFirewall = true; # Port: 7878
      };

      sonarr = {
        enable = true;
        dataDir = "${dataDir}/sonarr/.config/NzbDrone/";
        openFirewall = true; # Port: 8989
      };
    };

    systemd = {
      tmpfiles.rules = [
        "d ${dataDir}/lidarr 0755 lidarr lidarr"
        "d ${dataDir}/radarr 0755 radarr radarr"
        "d ${dataDir}/sonarr 0755 sonarr sonarr"
      ];
    };
  };
}
