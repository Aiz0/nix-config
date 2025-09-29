{
  config,
  self,
  pkgs,
  ...
}: {
  imports = [
    ./home.nix
    ./secrets.nix
    ./services.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];
  networking.hostName = "sakurasou";
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "uas" "sd_mod"];
  myDisko.installDrive = "/dev/disk/by-id/nvme-ADATA_SX8200PNP_2K1520121131";

  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-id/ata-ST2000LM015-2E8174_ZDZMNR7N";
      fsType = "btrfs";
      options = ["compress=zstd" "noatime" "nofail"];
    };
  };

  myHardware = {
    amd = {
      cpu.enable = true;
      gpu.enable = true;
    };
    profiles = {
      base.enable = true;
    };
  };

  environment.systemPackages = [pkgs.kdePackages.kdenlive];

  myNixOS = {
    desktop = {
      niri.enable = true;
    };
    profiles = {
      base.enable = true;
      arr.enable = true;
      btrfs.enable = true;
      swap = {
        enable = true;
        size = 16384;
      };
      workstation.enable = true;
    };
    programs = {
      nix.enable = true;
      systemd-boot.enable = true;
      steam = {
        enable = true;
        steamHome.enable = true;
        SGDBoop.enable = true;
      };
    };

    services = {
      noctalia.enable = true;
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
      tailscale = {
        enable = true;
        operator = "aiz";
      };
    };
  };

  users.groups.media = {
    gid = 900;
    members = ["radarr" "sonarr" "lidarr"];
  };

  myUsers.aiz.enable = true;

  system.stateVersion = "25.05";
}
