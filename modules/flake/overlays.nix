_: {
  flake.overlays = {
    default = final: prev: {
      # TODO: Remove when https://github.com/NixOS/nixpkgs/pull/530302 is merged
      regreet = prev.regreet.overrideAttrs (
        finalAttrs: previousAttrs: {
          buildInputs =
            previousAttrs.buildInputs
            ++ (with final; [
              gst_all_1.gstreamer
              gst_all_1.gst-plugins-base
              gst_all_1.gst-plugins-good
            ]);
        }
      );
    };
  };
}
