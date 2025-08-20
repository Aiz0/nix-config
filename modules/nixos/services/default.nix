{...}: {
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./keyd.nix
    ./qbittorrent.nix
    ./qbittorrent-hotio.nix
    ./recyclarr.nix
    ./tailscale.nix
  ];
}
