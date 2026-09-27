_: {
  flake.nixosModules.miyabi = {
    users.groups.media = {
      gid = 900;
      members = ["radarr" "sonarr" "lidarr" "shoko" "flexget" "slskd" "chaptarr"];
    };
  };
}
