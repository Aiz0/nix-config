{self, ...}: {
  flake.overlays = {
    default = _final: prev: {
      inherit (self.inputs.kavita-overlay.legacyPackages.${prev.system}) kavita;
    };
  };
}
