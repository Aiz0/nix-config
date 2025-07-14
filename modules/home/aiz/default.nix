{pkgs, ...}: {
  imports = [
    ./desktop
    ./programs
    ./services
  ];
  home = {
    username = "aiz";
    homeDirectory = "/home/aiz";

    packages = with pkgs; [
      neofetch

      # archives
      zip
      unzip
    ];

    stateVersion = "25.05";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
}
