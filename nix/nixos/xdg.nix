_: {
  flake.nixosModules.default = {
    environment.sessionVariables = let
      local = "$HOME/local";
    in {
      XDG_CONFIG_HOME = local + "/config";
      XDG_CACHE_HOME = local + "/cache";
      XDG_STATE_HOME = local + "/state";
      XDG_DATA_HOME = local + "/share";
    };
  };
}
