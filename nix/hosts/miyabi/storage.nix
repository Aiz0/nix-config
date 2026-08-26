_: {
  flake.nixosModules.miyabi = {
    fileSystems = {
      "/mnt/data" = {
        device = "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ9NHN4";
        fsType = "btrfs";
        options = ["compress=zstd" "noatime" "nofail"];
      };
    };
  };
}
