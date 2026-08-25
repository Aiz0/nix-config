_: {
  flake.nixosModules.miyabi = {config, ...}: let
    cfg = {
      dataDir = "/var/lib/navidrome";
      musicFolder = "/mnt/data/media/music";
    };
  in {
    services.navidrome = {
      enable = true;
      openFirewall = true; # port 4533
      settings = {
        MusicFolder = cfg.musicFolder;
        DataFolder = cfg.dataDir;
        # Make it accessible via the tailnet
        Address = "0.0.0.0";
        baseURL = "https://${config.mySnippets.tailnet.networkMap.navidrome.vHost}";
      };
    };
  };
}
