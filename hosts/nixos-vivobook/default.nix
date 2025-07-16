{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vivobook";
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11";
}
