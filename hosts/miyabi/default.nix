{config,self, ...}: {
  imports = [
    ./secrets.nix
    ./services.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];
  networking.hostName = "miyabi";
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];

  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ9NHN4";
      fsType = "btrfs";
      options = ["compress=zstd" "noatime" "nofail"];
    };
  };


  myHardware = {
    amd = {
      cpu.enable = true;
    };
    profiles = {
      base.enable = true;
    };
  };

  myNixOS = {
    profiles = {
      base.enable = true;
      arr.enable = true;
      btrfs.enable = true;
      swap.enable = true;
    };
    programs = {
      nix.enable = true;
      systemd-boot.enable = true;
    };

    services = {
      caddy.enable = true;
      recyclarr.enable = true;
      qbittorrent-hotio = {
        enable = true;
        inherit (config.mySnippets.tailnet.networkMap.qbittorrent) port;
        group = "media";
      };
      lanraragi = {
        enable = true;
        supplementaryGroups = ["media"];
      };
      jellyfin.enable = true;
      kavita.enable = true;
      shoko.enable = true;
      tailscale.enable = true;
    };
  };

  users.groups.media = {
    gid = 900;
    members = ["radarr" "sonarr" "lidarr" "shoko"];
  };

  system.stateVersion = "24.11";
}
