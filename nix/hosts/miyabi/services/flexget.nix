_: {
  flake.nixosModules.miyabi = let
    cfg = {
      dataDir = "/var/lib/";
      group = "media";
    };
  in {
    services.flexget = {
      enable = true;
      user = "flexget";
      interval = "1h";
      homeDir = "${cfg.dataDir}/flexget";

      config = ''
        variables: ${cfg.dataDir}/flexget/secrets.yml
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
              url: file://${cfg.dataDir}/flexget/anime.csv
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
      home = "${cfg.dataDir}/flexget";
      createHome = true;
      isSystemUser = true;
      inherit (cfg) group;
    };
  };
}
