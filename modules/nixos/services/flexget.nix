{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.flexget = {
    enable = lib.mkEnableOption "flexget daemon";

    dataDir = lib.mkOption {
      description = "Data directory to use.";
      default = "/var/lib";
      type = lib.types.str;
    };

    group = lib.mkOption {
      description = "Group to use.";
      default = "media";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.myNixOS.services.flexget.enable {
    services.flexget = {
      enable = true;
      user = "flexget";
      interval = "1h";
      homeDir = "${config.myNixOS.services.flexget.dataDir}/flexget";

      config = ''
        variables: ${config.myNixOS.services.flexget.dataDir}/flexget/secrets.yml
        templates:
          anime-series:
            configure_series:
              from:
                entry_list: anime-series
              settings:
                identified_by: auto
                special_ids:
                  - OVA
            content_filter:
              require:
                - "*.mkv"
                - "*.mp4"

          ##### Disable builtins for some tasks
          disable-seen-retry:
            disable:
              - seen
              - seen_info_hash
              - retry_failed

          ##### torrent config
          torrents:
            magnets: false
            domain_delay:
              nyaa.si: 10 seconds

          ##### qbittorrent
          qbittorrent:
            qbittorrent:
              username: "{? qbittorrent.username ?}"
              password: "{? qbittorrent.password ?}"

        tasks:
          fill-series:
            priority: 1
            template:
              - disable-seen-retry
            list_clear:
              what:
                - entry_list: anime-series
            csv:
              url: file://${config.myNixOS.services.flexget.dataDir}/flexget/anime.csv
              values:
                title: 1
                url: 2
            accept_all: true
            list_add:
              - entry_list: anime-series

          download-anime-series-shoko:
            priority: 10
            template:
              - anime-series
              - torrents
              - qbittorrent
            qbittorrent:
              label: shoko
            inputs:
              - rss: "{? rss.anime ?}"
      '';
    };

    users.users.flexget = {
      home = "${config.myNixOS.services.flexget.dataDir}/flexget";
      createHome = true;
      isSystemUser = true;
      group = config.myNixOS.services.flexget.group;
    };
  };
}
