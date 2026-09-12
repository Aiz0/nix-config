_: {
  flake.nixosModules.aiz = {
    config,
    lib,
    pkgs,
    self,
    ...
  }: {
    nix.settings.trusted-users = lib.mkAfter ["aiz"];
    sops.secrets.aiz-password = {
      neededForUsers = true;
      sopsFile = self + "/secrets/aiz-password.yaml";
    };
    users.groups.aiz = {};
    users.users.aiz = {
      description = "Aiz";
      group = "aiz";
      extraGroups = ["networkmanager" "wheel"];
      home = "/home/aiz";
      hashedPasswordFile = config.sops.secrets.aiz-password.path;
      isNormalUser = true;
      shell = pkgs.fish;
      uid = 1000;
    };
  };
}
