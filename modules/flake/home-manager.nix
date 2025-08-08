_: {
  flake = {
    homeConfigurations = {
      aiz = ../../homes/aiz;
    };

    homeModules = {
      default = ../home;
      snippets = ../snippets;
    };
  };
}
