{self, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
    ./home.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    programs.nix.enable = true;

    services.tailscale = {
      enable = true;
      operator = "aiz";
    };
  };

  myUsers.aiz.enable = true;

  system.stateVersion = "24.11";
}
