{self, ...}: {
  imports = [
    ./home.nix
    ./secrets.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];
  networking.hostName = "frieren";

  myHardware.framework.laptop13.amd-ai-300.enable = true;

  myNixOS = {
    desktop = {
      niri.enable = true;
    };
    profiles = {
      base.enable = true;
      btrfs.enable = true;
      swap.enable = true;
      workstation.enable = true;
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
