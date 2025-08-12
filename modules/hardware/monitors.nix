{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.myHardware.monitors = mkOption {
    type = types.listOf (types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          example = "DP-1";
        };
        width = mkOption {
          type = types.int;
          example = 1920;
        };
        height = mkOption {
          type = types.int;
          example = 1080;
        };
        refresh = {
          rate = mkOption {
            type = types.nullOr types.float;
            default = null;
          };
          variable = {
            enabled = lib.mkEnableOption "Enable variable refresh rate for this monitor";
            on-demand = lib.mkEnableOption "Only enable variable refresh rate when a window supports it";
          };
        };

        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        primary = mkOption {
          type = types.bool;
          default = false;
        };
      };
    });
    default = [];
  };
}
