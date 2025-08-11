{self, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./home.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];
  networking.hostName = "nixos-desktop";
  myDisko.installDrive = "/dev/disk/by-id/nvme-ADATA_SX8200PNP_2K1520121131";

  myHardware.profiles = {
    base.enable = true;
  };

  myNixOS = {
    desktop = {
      niri.enable = true;
    };
    profiles = {
      base.enable = true;
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

  system.stateVersion = "25.05";
}
