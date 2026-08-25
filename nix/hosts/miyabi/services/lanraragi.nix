_: {
  flake.nixosModules.miyabi = {
    services.lanraragi = {
      enable = true;
      openFirewall = true; # port 3000
    };

    systemd.services.lanraragi.serviceConfig.supplementaryGroups = "media";
  };
}
