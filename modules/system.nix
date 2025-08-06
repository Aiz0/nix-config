{
  pkgs,
  lib,
  ...
}: {
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    fuzzel
    nixd
    alejandra
  ];

  # required for hyprlock to perform authentication
  security.pam.services.hyprlock = {};
}
