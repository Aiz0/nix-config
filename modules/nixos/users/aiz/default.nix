{pkgs, ...}: {
  users.users.aiz = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];

    shell = pkgs.fish;
    uid = 1000;
  };
}
