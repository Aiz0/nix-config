{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixOS.programs.podman = {
    enable = lib.mkEnableOption "enable podman";
  };

  config = lib.mkIf config.myNixOS.programs.podman.enable {
    environment.systemPackages = [pkgs.podman-compose];

    # Runtime
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
    };

    # Enable container name DNS for all Podman networks.
    networking.firewall.interfaces = let
      matchAll =
        if !config.networking.nftables.enable
        then "podman+"
        else "podman*";
    in {
      "${matchAll}".allowedUDPPorts = [53];
    };

    virtualisation.oci-containers.backend = "podman";
  };
}
