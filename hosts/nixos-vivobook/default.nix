{self, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./home.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];
  networking.hostName = "nixos-vivobook";

  myHardware.profiles = {
    base.enable = true;
    laptop.enable = true;
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
    };

    services.tailscale = {
      enable = true;
      operator = "aiz";
    };
  };

  myUsers.aiz.enable = true;

  system.stateVersion = "24.11";
}
