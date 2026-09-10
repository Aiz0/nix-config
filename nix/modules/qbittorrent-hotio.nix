_: {
  flake.nixosModules.qbittorrent = {
    pkgs,
    lib,
    config,
    ...
  }: let
    cfg = {
      dataDir = "/var/lib/qbittorrent-hotio";
      downloadDir = "/mnt/data/";
      user = "qbittorrent";
      group = "media";
      port = 8080;
    };
    UID = 888;
    GID = 888;
  in {
    # Containers
    virtualisation.oci-containers.containers."qbittorrent" = {
      image = "ghcr.io/hotio/qbittorrent";
      environment = {
        "LIBTORRENT" = "v1";
        "PGID" = toString config.users.groups."${cfg.group}".gid;
        "PUID" = toString config.users.users."${cfg.user}".uid;
        "TZ" = config.time.timeZone;
        "UMASK" = "002";
        "PRIVOXY_ENABLED" = "false";
        "UNBOUND_ENABLED" = "false";
        "VPN_AUTO_PORT_FORWARD" = "true";
        "VPN_AUTO_PORT_FORWARD_TO_PORTS" = "";
        "VPN_CONF" = "wg0";
        "VPN_PROVIDER" = "proton";
        "VPN_ENABLED" = "true";
        "VPN_FIREWALL_TYPE" = "auto";
        "VPN_HEALTHCHECK_ENABLED" = "false";
        "VPN_LAN_LEAK_ENABLED" = "false";
        "VPN_LAN_NETWORK" = "192.168.1.0/24";
        "VPN_NAMESERVERS" = "";
        "WEBUI_PORTS" = "8080/tcp,8080/udp";
      };
      volumes = [
        "${cfg.downloadDir}:/data/:rw"
        "${cfg.dataDir}:/config:rw"
      ];
      ports = [
        "${toString cfg.port}:8080/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--device=/dev/net/tun:/dev/net/tun:rwm"
        "--hostname=container-name.internal"
        "--network-alias=qbittorrent"
        "--network=qbittorrent-hotio_default"
        "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
        "--sysctl=net.ipv6.conf.all.disable_ipv6=1"
      ];
    };
    systemd.services."podman-qbittorrent" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "no";
      };
      after = [
        "podman-network-qbittorrent-hotio_default.service"
        # IMPORTANT: Wait for the download directory to be mounted
        # TODO: add config for this since mnt-data is only the default
        "local-fs.target" # Ensures local filesystems are mounted
        "mnt-data.mount" # Explicitly wait for /mnt/data
      ];
      requires = [
        "podman-network-qbittorrent-hotio_default.service"
      ];
      partOf = [
        "podman-compose-root.target"
      ];
      wantedBy = [
        "podman-compose-root.target"
      ];
    };

    # Networks
    systemd.services."podman-network-qbittorrent-hotio_default" = {
      path = [pkgs.podman];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f qbittorrent-hotio_default";
      };
      script = ''
        podman network inspect qbittorrent-hotio_default || podman network create qbittorrent-hotio_default
      '';
      partOf = ["podman-compose-root.target"];
      wantedBy = ["podman-compose-root.target"];
    };
    users.users = lib.mkIf (cfg.user == "qbittorrent") {
      qbittorrent = {
        inherit (cfg) group;
        uid = UID;
      };
    };

    users.groups =
      lib.mkIf (cfg.group == "qbittorrent") {qbittorrent = {gid = GID;};};
  };
}
