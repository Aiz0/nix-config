{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.recyclarr = {
    enable = lib.mkEnableOption "Enable recyclarr for sonarr and radarr. Single instance";
    radarr = {
      base_url = lib.mkOption {
        default =
          if config.mySnippets.tailnet.networkMap.radarr.vHost != null
          then "https://${config.mySnippets.tailnet.networkMap.radarr.vHost}"
          else "http://localhost:7878";
        description = "Base url for radarr";
        type = lib.types.str;
      };
      authKeyFile = lib.mkOption {
        description = "Key file to use for authentication";
        default = config.age.secrets.radarrApiKey.path or null;
        type = lib.types.nullOr lib.types.path;
      };
    };
    sonarr = {
      base_url = lib.mkOption {
        default =
          if config.mySnippets.tailnet.networkMap.sonarr.vHost != null
          then "https://${config.mySnippets.tailnet.networkMap.sonarr.vHost}"
          else "http://localhost:8989";
        description = "Base url for sonarr";
        type = lib.types.str;
      };
      authKeyFile = lib.mkOption {
        description = "Key file to use for authentication";
        default = config.age.secrets.sonarrApiKey.path or null;
        type = lib.types.nullOr lib.types.path;
      };
    };
  };

  config = lib.mkIf config.myNixOS.services.recyclarr.enable {
    assertions = [
      {
        assertion = config.myNixOS.services.recyclarr.radarr.authKeyFile != null;
        message = "config.recyclarr.radarr.authKeyFile cannot be null.";
      }
      {
        assertion = config.myNixOS.services.recyclarr.sonarr.authKeyFile != null;
        message = "config.recyclarr.sonarr.authKeyFile cannot be null.";
      }
    ];
    services.recyclarr = {
      enable = true;
      schedule = "weekly";
      configuration = {
        radarr = {
          "web+anime-radarr" = {
            api_key = {
              _secret = "/run/credentials/recyclarr.service/radarr-api_key";
            };
            inherit (config.myNixOS.services.recyclarr.radarr) base_url;
            include = [
              {template = "radarr-quality-definition-movie";}
              {template = "radarr-quality-profile-hd-bluray-web";}
              {template = "radarr-custom-formats-hd-bluray-web";}
              {template = "radarr-quality-profile-anime";}
              {template = "radarr-custom-formats-anime";}
            ];
            replace_existing_custom_formats = true;
            custom_formats = [
              {
                trash_ids = null;
                assign_scores_to = [{name = "HD Bluray + WEB";}];
              }
              {
                trash_ids = null;
                assign_scores_to = [{name = "HD Bluray + WEB";}];
              }
              {
                trash_ids = null;
                assign_scores_to = [{name = "HD Bluray + WEB";}];
              }
              {
                trash_ids = ["064af5f084a0a24458cc8ecd3220f93f"];
                assign_scores_to = [
                  {
                    name = "Remux-1080p - Anime";
                    score = 0;
                  }
                ];
              }
              {
                trash_ids = ["a5d148168c4506b55cf53984107c396e"];
                assign_scores_to = [
                  {
                    name = "Remux-1080p - Anime";
                    score = 0;
                  }
                ];
              }
              {
                trash_ids = ["4a3b087eea2ce012fcc1ce319259a3be"];
                assign_scores_to = [
                  {
                    name = "Remux-1080p - Anime";
                    score = 0;
                  }
                ];
              }
            ];
          };
        };
        sonarr = {
          "web+anime-sonarr" = {
            api_key = {
              _secret = "/run/credentials/recyclarr.service/sonarr-api_key";
            };
            inherit (config.myNixOS.services.recyclarr.sonarr) base_url;
            include = [
              {template = "sonarr-quality-definition-series";}
              {template = "sonarr-v4-quality-profile-web-1080p-alternative";}
              {template = "sonarr-v4-custom-formats-web-1080p";}
              {template = "sonarr-quality-definition-anime";}
              {template = "sonarr-v4-quality-profile-anime";}
              {template = "sonarr-v4-custom-formats-anime";}
            ];
            replace_existing_custom_formats = true;
            custom_formats = [
              {
                trash_ids = null;
                assign_scores_to = [{name = "WEB-1080p";}];
              }
              {
                trash_ids = null;
                assign_scores_to = [{name = "WEB-1080p";}];
              }
              {
                trash_ids = ["026d5aadd1a6b4e550b134cb6c72b3ca"];
                assign_scores_to = [
                  {
                    name = "Remux-1080p - Anime";
                    score = 0;
                  }
                ];
              }
              {
                trash_ids = ["b2550eb333d27b75833e25b8c2557b38"];
                assign_scores_to = [
                  {
                    name = "Remux-1080p - Anime";
                    score = 0;
                  }
                ];
              }
              {
                trash_ids = ["418f50b10f1907201b6cfdf881f467b7"];
                assign_scores_to = [
                  {
                    name = "Remux-1080p - Anime";
                    score = 0;
                  }
                ];
              }
            ];
          };
        };
      };
    };

    systemd.services.recyclarr.serviceConfig.LoadCredential = [
      "radarr-api_key:${config.myNixOS.services.recyclarr.radarr.authKeyFile}"
      "sonarr-api_key:${config.myNixOS.services.recyclarr.sonarr.authKeyFile}"
    ];
  };
}
