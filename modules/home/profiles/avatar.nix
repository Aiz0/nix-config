{lib, ...}: {
  options.myHome.profiles.avatar = {
    path = lib.mkOption {
      description = "Path to user avatar";
      default = null;
      type = lib.types.nullOr lib.types.path;
    };
  };
}
