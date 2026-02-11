{config, ...}: {
  services = {
    caddy.virtualHosts = {
      "${config.mySnippets.tailnet.networkMap.bazarr.vHost}" = {
        extraConfig = ''
          bind tailscale/bazarr
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.bazarr.hostName}:${toString config.mySnippets.tailnet.networkMap.bazarr.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.jellyfin.vHost}" = {
        extraConfig = ''
          bind tailscale/jellyfin
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.jellyfin.hostName}:${toString config.mySnippets.tailnet.networkMap.jellyfin.port} {
            flush_interval -1
          }
        '';
      };

      "${config.mySnippets.tailnet.networkMap.kavita.vHost}" = {
        extraConfig = ''
          bind tailscale/kavita
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.kavita.hostName}:${toString config.mySnippets.tailnet.networkMap.kavita.port} {
            flush_interval -1
          }
        '';
      };

      "${config.mySnippets.tailnet.networkMap.lanraragi.vHost}" = {
        extraConfig = ''
          bind tailscale/lanraragi
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.lanraragi.hostName}:${toString config.mySnippets.tailnet.networkMap.lanraragi.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.lidarr.vHost}" = {
        extraConfig = ''
          bind tailscale/lidarr
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.lidarr.hostName}:${toString config.mySnippets.tailnet.networkMap.lidarr.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.prowlarr.vHost}" = {
        extraConfig = ''
          bind tailscale/prowlarr
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.prowlarr.hostName}:${toString config.mySnippets.tailnet.networkMap.prowlarr.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.qbittorrent.vHost}" = {
        extraConfig = ''
          bind tailscale/qbittorrent
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.qbittorrent.hostName}:${toString config.mySnippets.tailnet.networkMap.qbittorrent.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.radarr.vHost}" = {
        extraConfig = ''
          bind tailscale/radarr
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.radarr.hostName}:${toString config.mySnippets.tailnet.networkMap.radarr.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.shoko.vHost}" = {
        extraConfig = ''
          bind tailscale/shoko
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.shoko.hostName}:${toString config.mySnippets.tailnet.networkMap.shoko.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.sonarr.vHost}" = {
        extraConfig = ''
          bind tailscale/sonarr
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.sonarr.hostName}:${toString config.mySnippets.tailnet.networkMap.sonarr.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.grafana.vHost}" = {
        extraConfig = ''
          bind tailscale/grafana
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.grafana.hostName}:${toString config.mySnippets.tailnet.networkMap.grafana.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.loki.vHost}" = {
        extraConfig = ''
          bind tailscale/loki
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.loki.hostName}:${toString config.mySnippets.tailnet.networkMap.loki.port}
        '';
      };

      "${config.mySnippets.tailnet.networkMap.prometheus.vHost}" = {
        extraConfig = ''
          bind tailscale/prometheus
          encode zstd gzip
          reverse_proxy ${config.mySnippets.tailnet.networkMap.prometheus.hostName}:${toString config.mySnippets.tailnet.networkMap.prometheus.port}
        '';
      };
    };
  };
}
