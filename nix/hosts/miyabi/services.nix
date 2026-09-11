_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    ...
  }: {
    options.mySnippets.tailnet = {
      name = lib.mkOption {
        default = "miku-climb.ts.net";
        description = "Tailnet name.";
        type = lib.types.str;
      };

      networkMap = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            port = lib.mkOption {type = lib.types.port;};
            vHost = lib.mkOption {type = lib.types.str;};
            extraStuff = lib.mkOption {
              type = lib.types.str;
              default = "";
            };
          };
        });
        description = "Ports, and vHosts for ${config.mySnippets.tailnet.name} services.";

        default = {
          bazarr = {
            port = 6767;
            vHost = "bazarr.${config.mySnippets.tailnet.name}";
          };

          jellyfin = {
            port = 8096;
            vHost = "jellyfin.${config.mySnippets.tailnet.name}";
            extraStuff = "{ flush_interval -1 }";
          };

          kavita = {
            port = 5000;
            vHost = "kavita.${config.mySnippets.tailnet.name}";
          };

          komf = {
            port = 8085;
            vHost = "komf.${config.mySnippets.tailnet.name}";
          };

          grafana = {
            port = 3010;
            vHost = "grafana.${config.mySnippets.tailnet.name}";
          };

          lanraragi = {
            port = 3000;
            vHost = "lanraragi.${config.mySnippets.tailnet.name}";
          };

          multiScrobbler = {
            port = 9078;
            vHost = "multiscrobbler.${config.mySnippets.tailnet.name}";
          };

          navidrome = {
            port = 4533;
            vHost = "navidrome.${config.mySnippets.tailnet.name}";
          };

          lidarr = {
            port = 8686;
            vHost = "lidarr.${config.mySnippets.tailnet.name}";
          };

          loki = {
            port = 3030;
            vHost = "loki.${config.mySnippets.tailnet.name}";
          };

          prometheus = {
            port = 3020;
            vHost = "prometheus.${config.mySnippets.tailnet.name}";
          };

          prowlarr = {
            port = 9696;
            vHost = "prowlarr.${config.mySnippets.tailnet.name}";
          };

          qbittorrent = {
            port = 8080;
            vHost = "qbittorrent.${config.mySnippets.tailnet.name}";
          };

          radarr = {
            port = 7878;
            vHost = "radarr.${config.mySnippets.tailnet.name}";
          };

          shoko = {
            port = 8111;
            vHost = "shoko.${config.mySnippets.tailnet.name}";
          };

          sonarr = {
            port = 8989;
            vHost = "sonarr.${config.mySnippets.tailnet.name}";
          };

          slskd = {
            port = 5030;
            vHost = "slskd.${config.mySnippets.tailnet.name}";
          };
        };
      };
    };
    config.services = {
      caddy.virtualHosts = builtins.listToAttrs (lib.attrsets.mapAttrsToList
        (name: service: {
          name = service.vHost;
          value.extraConfig = ''
            bind tailscale/${name}
            encode zstd gzip
            reverse_proxy ${config.networking.hostName}:${toString service.port} ${service.extraStuff}
          '';
        })
        config.mySnippets.tailnet.networkMap);
    };
  };
}
