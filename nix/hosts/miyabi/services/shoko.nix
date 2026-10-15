_: {
  flake.nixosModules.miyabi = {
    services.shoko = {
      enable = true;
      openFirewall = true; # port 8111
    };
    # not automatic, happens before upgrading to latest release, not sure how that works with nix
    myBackup.paths = [
      "/var/lib/shoko/DatabaseBackup"
    ];
  };
}
