_: {
  flake.nixosModules.sakurasou = {
    fileSystems = {
      "/mnt/data" = {
        device = "/dev/disk/by-id/ata-ST2000LM015-2E8174_ZDZMNR7N";
        fsType = "btrfs";
        options = ["compress=zstd" "noatime" "nofail"];
      };
    };
  };
}
