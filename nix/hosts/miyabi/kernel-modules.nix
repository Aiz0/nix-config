_: {
  flake.nixosModules.miyabi = {
    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  };
}
