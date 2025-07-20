{self, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
    self.diskoConfigurations.luks-btrfs-subvolumes
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vivobook";
  networking.networkmanager.enable = true;
  
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };
  services.xserver.exportConfiguration = true;
  console.useXkbConfig = true;

  system.stateVersion = "24.11";
}
