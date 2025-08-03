{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myUsers.aiz.enable {
    users.users.aiz = {
      description = "Aiz";
      extraGroups = config.myUsers.defaultGroups;
      # TODO: add passwords declaratively
      # hashedPassword = config.myUsers.aiz.password;
      isNormalUser = true;

      shell = pkgs.fish;
      uid = 1000;
    };
  };
}
