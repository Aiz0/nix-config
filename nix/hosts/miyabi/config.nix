_: {
  flake.nixosModules.miyabi = {
    self,
    config,
    ...
  }: {
    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];

    nixpkgs.config.nvidia.acceptLicense = true;
    # myHardware = {
    #   amd = {
    #     cpu.enable = true;
    #   };
    #   nvidia = {
    #     gpu.enable = true;
    #   };
    #   profiles = {
    #     base.enable = true;
    #   };
    # };

    # myNixOS = {
    #   # profiles = {
    #   #   base.enable = true;
    #   #   arr.enable = true;
    #   #   btrfs.enable = true;
    #   #   swap.enable = true;
    #   # };
    #   # programs = {
    #   #   nix.enable = true;
    #   #   systemd-boot.enable = true;
    #   # };

    #   services = {
    #     # qbittorrent-hotio = {
    #     #   enable = true;
    #     #   inherit (config.mySnippets.tailnet.networkMap.qbittorrent) port;
    #     #   group = "media";
    #     # };
    #     # # prometheusNode.enable = true; # enable again later
    #     # tailscale = {
    #     #   enable = true;
    #     #   operator = "aiz";
    #     # };
    #   };
    # };

    users.groups.media = {
      gid = 900;
      members = ["radarr" "sonarr" "lidarr" "shoko" "flexget" "slskd"];
    };

    # myUsers.aiz.enable = true;
  };
}
