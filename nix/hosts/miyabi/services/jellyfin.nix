_: {
  flake.nixosModules.miyabi = {
    services.jellyfin = {
      enable = true;
      openFirewall = true; # port 8096
      dataDir = "/var/lib/jellyfin";
    };
  };
}
