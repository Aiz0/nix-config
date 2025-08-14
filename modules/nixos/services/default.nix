{...}: {
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./keyd.nix
    ./qbittorrent.nix
    ./tailscale.nix
  ];
}
