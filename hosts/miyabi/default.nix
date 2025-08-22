{self, ...}: {
  imports = [
    ./home.nix
    ./secrets.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];
  networking.hostName = "miyabi";
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc"];

  myHardware = {
    amd = {
      cpu.enable = true;
      gpu.enable = true;
    };
    profiles = {
      base.enable = true;
      laptop.enable = true;
    };
  };

  myNixOS = {
    desktop = {
      niri.enable = true;
    };
    profiles = {
      base.enable = true;
      btrfs.enable = true;
      swap.enable = true;
    };
    programs = {
      nix.enable = true;
      systemd-boot.enable = true;
      steam = {
        enable = true;
        steamHome.enable = true;
      };
    };

    services.tailscale = {
      enable = true;
      operator = "aiz";
    };
  };

  myUsers.aiz.enable = true;

  system.stateVersion = "24.11";
}
