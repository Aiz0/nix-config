{...}: {
  disko.devices = {
    disk = {
      media = {
        type = "disk";
        device = "/dev/disk/by-id/ata-ST2000LM015-2E8174_ZDZMNR7N";

        content = {
          type = "btrfs";
          mountpoint = "/mnt/media";
          mountOptions = ["compress=zstd" "noatime"];
        };
      };
    };
  };
}
