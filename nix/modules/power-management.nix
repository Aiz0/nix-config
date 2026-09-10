_: {
  flake.nixosModules.power-management = {
    services = {
      upower.enable = true;
      tuned = {
        enable = true;
        settings.dynamic_tuning = true;
      };
    };
  };
}
