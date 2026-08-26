_: {
  flake.nixosModules.default = {
    console.useXkbConfig = true;
    # default to EurKEY keyboard layout
    services.xserver.xkb.layout = "eu";
  };
}
