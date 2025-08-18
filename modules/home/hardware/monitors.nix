{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.myHome.hardware.monitors = mkOption {
    type = types.listOf (types.submodule {
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
        primary = mkOption {
          type = types.bool;
          default = false;
        };
        width = mkOption {
          type = types.int;
          example = 1920;
        };
        height = mkOption {
          type = types.int;
          example = 1080;
        };
        refreshRate = {
          value = mkOption {
            type = types.nullOr types.float;
            default = null;
          };
          variable = {
            enabled = lib.mkEnableOption "Enable variable refresh rate for this monitor";
            on-demand = lib.mkEnableOption "Only enable variable refresh rate when a window supports it";
          };
        };
        position = {
          x = mkOption {
            type = types.int;
            default = 0;
          };
          y = mkOption {
            type = types.int;
            default = 0;
          };
        };
        scale = mkOption {
          type = types.str;
          default = "1";
        };
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        wallpaper = {
          path = mkOption {
            type = types.nullOr types.path;
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
          ((lib.length config.myHome.hardware.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.myHome.hardware.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
    ];
  };
}
