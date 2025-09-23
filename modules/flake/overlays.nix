{self, ...}: {
  flake.overlays = {
    default = _final: prev: {
      inherit (self.inputs.shoko-anime.legacyPackages.${prev.system}) shoko shoko-webui;
    };
  };
}
