{
  pkgs,
  config,
  self,
  lib,
  ...
}: {
  imports = [
    self.homeModules.default
  ];

  config = {
    home = {
      packages = with pkgs; [
        # Dev
        nodejs
        deno
        pnpm
        pakku
        live-server
      ];
    };

    systemd.user.startServices = true; # Needed for auto-mounting agenix secrets.

    myHome = {
      profiles = {
        defaultApps = {
          enable = true;
          forceMimeAssociations = true;
        };
      };

      aiz = {
        desktop = {
          niri.enable = true;
        };
      };
    };
  };
}
