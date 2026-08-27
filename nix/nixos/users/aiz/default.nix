_: {
  flake.nixosModules.aiz = {
    config,
    lib,
    pkgs,
    ...
  }: {
    nix.settings.trusted-users = lib.mkAfter ["aiz"];
    users.groups.aiz = {};
    users.users.aiz = {
      description = "Aiz";
      group = "aiz";
      extraGroups = ["networkmanager" "wheel"];
      home = "/home/aiz";
      # TODO: add passwords declaratively
      # hashedPassword = config.myUsers.aiz.password;
      isNormalUser = true;
      shell = pkgs.fish;
      uid = 1000;
    };
  };
}
