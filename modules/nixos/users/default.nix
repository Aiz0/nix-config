# set user defaults and imports users
{pkgs, ...}: {
  imports = [
    ./aiz
  ];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
}
