_: {
  flake.nixosModules.miyabi = {config, ...}: {
    services.prometheus.exporters = {
      exportarr-bazarr = {
        enable = true;
        apiKeyFile = config.sops.secrets.bazarr-api-key.path;
        port = 9708;
        url = "https://${config.mySnippets.tailnet.networkMap.bazarr.vHost}";
      };

      exportarr-lidarr = {
        enable = true;
        apiKeyFile = config.sops.secrets.lidarr-api-key.path;
        port = 9709;
        url = "https://${config.mySnippets.tailnet.networkMap.lidarr.vHost}";
      };

      exportarr-prowlarr = {
        enable = true;
        apiKeyFile = config.sops.secrets.prowlarr-api-key.path;
        port = 9710;
        url = "https://${config.mySnippets.tailnet.networkMap.prowlarr.vHost}";
      };

      exportarr-radarr = {
        enable = true;
        apiKeyFile = config.sops.secrets.radarr-api-key.path;
        port = 9711;
        url = "https://${config.mySnippets.tailnet.networkMap.radarr.vHost}";
      };

      exportarr-sonarr = {
        enable = true;
        apiKeyFile = config.sops.secrets.sonarr-api-key.path;
        port = 9712;
        url = "https://${config.mySnippets.tailnet.networkMap.sonarr.vHost}";
      };

      smartctl.enable = true;
    };
  };
}
