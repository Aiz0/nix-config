_: {
  flake.nixosModules.miyabi = {
    services.shoko = {
      enable = true;
      openFirewall = true; # port 8111
    };
  };
}
