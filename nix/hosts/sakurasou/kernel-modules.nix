_: {
  flake.nixosModules.sakurasou = {
    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "uas" "sd_mod"];
  };
}
