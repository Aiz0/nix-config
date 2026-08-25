# TODO: update this to Aly's hoenn swap module
# when i try facter
_: {
  flake.nixosModules.default = {
    config,
    lib,
    ...
  }: let
    # TODO: I didn't wanna add options at the moment so everything uses the default
    defaultSwapSizeMiB = 8192;
  in {
    swapDevices = [
      {
        device = "/.swap";
        priority = 0;
        randomEncryption.enable = true;
        size = defaultSwapSizeMiB;
      }
    ];
  };
}
