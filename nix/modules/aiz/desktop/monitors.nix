_: {
  flake.homeModules.aizDesktop = {
    config,
    lib,
    ...
  }: {
    options.myHome.monitors = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = {
            manufacturer = lib.mkOption {
              type = lib.types.str;
              example = "LG Electronics";
            };
            model = lib.mkOption {
              type = lib.types.str;
              example = "LG ULTRAGEAR";
            };
            serial = lib.mkOption {
              type = lib.types.str;
              example = "102NTKFG9141";
            };
          };
          plug = lib.mkOption {
            type = lib.types.str;
            example = "DP-1";
          };
          primary = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          width = lib.mkOption {
            type = lib.types.int;
            example = 1920;
          };
          height = lib.mkOption {
            type = lib.types.int;
            example = 1080;
          };
          refreshRate = {
            value = lib.mkOption {
              type = lib.types.nullOr lib.types.float;
              default = null;
            };
            variable = {
              enabled = lib.mkEnableOption "Enable variable refresh rate for this monitor";
              on-demand = lib.mkEnableOption "Only enable variable refresh rate when a window supports it";
            };
          };
          position = {
            x = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            y = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
          };
          scale = lib.mkOption {
            type = lib.types.str;
            default = "1";
          };
          enabled = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          wallpaper = {
            path = lib.mkOption {
              type = lib.types.nullOr lib.types.path;
            };
          };
        };
      });
      default = [];
    };
    config = {
      assertions = [
        {
          assertion =
            ((lib.length config.myHome.monitors) != 0)
            -> ((lib.length (lib.filter (m: m.primary) config.myHome.monitors)) == 1);
          message = "Exactly one monitor must be set to primary.";
        }
      ];
    };
  };
}
