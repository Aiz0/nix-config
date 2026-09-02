_: {
  flake.nixosModules.miyabi = {
    self,
    config,
    ...
  }: {
    #   services = {
    #     # qbittorrent-hotio = {
    #     #   enable = true;
    #     #   inherit (config.mySnippets.tailnet.networkMap.qbittorrent) port;
    #     #   group = "media";
    #     # };
    #   };
    # };
  };
}
