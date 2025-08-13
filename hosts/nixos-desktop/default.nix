{self, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./home.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];
  networking.hostName = "nixos-desktop";
  myDisko.installDrive = "/dev/disk/by-id/nvme-ADATA_SX8200PNP_2K1520121131";

  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-id/ata-ST2000LM015-2E8174_ZDZMNR7N";
      fsType = "btrfs";
      options = ["compress=zstd" "noatime" "nofail"];
    };
  };

  myHardware = {
    profiles = {
      base.enable = true;
    };
    monitors = [
      {
        name = "LG Electronics LG ULTRAGEAR 102NTKFG9141";
        width = 2560;
        height = 1440;
        x = 0;
        y = 0;
        primary = true;
        refresh.variable.enabled = true;
      }
      {
        name = "PNP(BNQ) BenQ GW2470 V8F02974019";
        width = 1920;
        height = 1080;
        x = -1920;
        y = 0;
      }
    ];
  };

  myNixOS = {
    desktop = {
      niri.enable = true;
    };
    profiles = {
      base.enable = true;
      arr.enable = true;
    };
    programs = {
      nix.enable = true;
      systemd-boot.enable = true;
      steam = {
        enable = true;
        steamHome.enable = true;
      };
    };

    services = {
      qbittorrent = {
        enable = true;
      };
      jellyfin.enable = true;
      tailscale = {
        enable = true;
        operator = "aiz";
      };
    };
  };

  myUsers.aiz.enable = true;

  system.stateVersion = "25.05";
}
