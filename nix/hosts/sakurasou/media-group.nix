_: {
  flake.nixosModules.sakurasou = {
    users.groups.media = {
      gid = 900;
    };
  };
}
