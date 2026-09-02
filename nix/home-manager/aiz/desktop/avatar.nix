_: {
  flake.homeModules.aizDesktop = {lib, ...}: {
    # TODO: convince myself this should be here or move it elsewhere
    options.flake.aizDesktop.avatar = {
      path = lib.mkOption {
        description = "Path to user avatar";
        default = builtins.path {path = ./assets/avatar.webp;};
        type = lib.types.nullOr lib.types.path;
      };
    };
  };
}
