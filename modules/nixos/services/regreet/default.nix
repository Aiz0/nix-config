{...}: {
  # Display Manager
  programs.regreet = {
    enable = true;
  };

  services.greetd.enable = true;
}
