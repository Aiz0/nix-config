_: {
  flake.nixosModules.sakurasou = {
    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "uas" "sd_mod"];

    # myNixOS = {
    #   desktop = {
    #     niri.enable = true;
    #   };
    # };

    users.groups.media = {
      gid = 900;
    };
  };
}
